//
//  TrainingViewModel.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Combine
import Network

enum TrainingViewModelState {
    case initial
    case startLoading
    case stopLoading
    case didChangeDataSuccess
    case failed(_ error: String)
}

protocol TrainingViewModelType {
    var viewModelState: AnyPublisher<TrainingViewModelState, Never> { get }
    var weekTrainingData: [DayOfWeekTrainingData] { get set }
    
    func getDayData()
    func didChangeWorkout(assignment: Assignment)
}

class TrainingViewModel: TrainingViewModelType {
    
    var viewModelState: AnyPublisher<TrainingViewModelState, Never> {
        state.eraseToAnyPublisher()
    }
    
    var weekTrainingData: [DayOfWeekTrainingData] = []
    
    private var state = CurrentValueSubject<TrainingViewModelState, Never>(.initial)
    private var cancellables = Set<AnyCancellable>()
    private let workoutUsercase: WorkoutUsercase
    private let localDatabase: LocalDatabase
    
    init(workoutUsercase: WorkoutUsercase, localDatabase: LocalDatabase) {
        self.workoutUsercase = workoutUsercase
        self.localDatabase = localDatabase
        handleMapDayToTrainingData()
        listenNetwork()
    }
    
    func getDayData() {
        state.send(.startLoading)
        workoutUsercase.getWorkouts()
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.state.send(.stopLoading)
            })
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.weekTrainingData = self?.localDatabase.store.getWeekTrainingWorkout().first?.dayOfWeekTrainingData ?? []
                    self?.state.send(.failed(error.localizedDescription))
                }
            }, receiveValue: { [weak self] listTrainingData in
                self?.handleAfterGetWorkouts(listTrainingData)
                self?.state.send(.didChangeDataSuccess)
            })
            .store(in: &cancellables)
    }
    
    func didChangeWorkout(assignment: Assignment) {
        guard let index = weekTrainingData.firstIndex(where: {
            $0.trainingData?.assignments.contains(where: { $0.id == assignment.id }) == true
        }),
              let trainingData = weekTrainingData[index].trainingData,
              let assignmentIndex = trainingData.assignments.firstIndex(where: { $0.id == assignment.id }) else {
            return
        }
        
        weekTrainingData[index].trainingData?.assignments[assignmentIndex].workoutToggle()
//        if let assignments = weekTrainingData[index].trainingData?.assignments[assignmentIndex] {
//            localDatabase.store.updateAssignmentStatus(assignmentId: assignments.id, status: assignments.status.rawValue)
//        }
        localDatabase.store.saveWeekTrainingWorkout(with: WeekTrainingData(dayOfWeekTrainingData: weekTrainingData))
        state.send(.didChangeDataSuccess)
    }
    
    private func handleMapDayToTrainingData() {
        let currentWeek = Date.fetchCurrentWeek()
        weekTrainingData = currentWeek.map { date in
            let dateStr = date.toString(format: AppDateFormat.localDate.rawValue)
            return DayOfWeekTrainingData(date: dateStr, trainingData: nil)
        }
    }
    
    private func handleAfterGetWorkouts(_ listTrainingData: [WorkoutData]) {
        for (index, dayData) in weekTrainingData.enumerated() {
            if let matchingTrainingData = listTrainingData.first(where: { $0.day == dayData.date }) {
                weekTrainingData[index].trainingData = matchingTrainingData
            }
        }
        handleMapStatusWorkoutedToData()
        workoutUsercase.saveDayOfWeekTrainingDatas(weekTrainingData)
        let weekTrainingData = WeekTrainingData(dayOfWeekTrainingData: weekTrainingData)
        localDatabase.store.saveWeekTrainingWorkout(with: weekTrainingData)
    }
    
    private func listenNetwork() {
        var currentStatus = NetworkMonitor.shared.networkStatus.value
        NetworkMonitor.shared.networkStatus
            .sink { [weak self] state in
                switch state {
                case .satisfied:
                    if currentStatus == .unsatisfied {
                        self?.getDayData()
                    }
                default:
                    break
                }
                currentStatus = state
            }
            .store(in: &cancellables)
    }
}

extension TrainingViewModel {
    private func handleMapStatusWorkoutedToData() {
//        let localData = workoutUsercase.getLocalDayOfWeekTrainingDatas() ?? []
        let localData = localDatabase.store.getWeekTrainingWorkout().first?.dayOfWeekTrainingData ?? []
        print("LOGG====> \(localData)")
        for dayData in localData {
            guard let assignmentsLocal = dayData.trainingData?.assignments,
                  let dayDataIndex = weekTrainingData.firstIndex(where: { $0.date == dayData.date }) else { continue }
            updateAssignmentsStatus(localAssignments: assignmentsLocal, dayDataIndex: dayDataIndex)
        }
    }
    
    private func updateAssignmentsStatus(localAssignments: [Assignment], dayDataIndex: Int) {
        for assignmentLocal in localAssignments {
            guard let assignmentIndex = findAssignmentIndex(for: assignmentLocal.id, in: dayDataIndex) else { continue }
            weekTrainingData[dayDataIndex]
            .trainingData?
            .assignments[assignmentIndex]
            .updateStatus(newValue: assignmentLocal.status)       
        }
    }
    
    private func findAssignmentIndex(for id: String, in dayDataIndex: Int) -> Int? {
        return weekTrainingData[dayDataIndex]
            .trainingData?
            .assignments
            .firstIndex { $0.id == id }
    }
}
