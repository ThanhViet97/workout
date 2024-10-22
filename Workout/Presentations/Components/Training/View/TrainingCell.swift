//
//  TrainingCell.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

class TrainingCell: UITableViewCell {
    
    @IBOutlet private weak var dayOfWeekLabel: UILabel!
    @IBOutlet private weak var dayOfMonthLabel: UILabel!
    @IBOutlet private weak var workoutStackView: UIStackView!
    @IBOutlet private weak var stackView: UIStackView!
    
    var didTapWorkout: ((Assignment) -> Void)?
    
    var dayOfWeekTrainingData: DayOfWeekTrainingData? {
        didSet {
            setupUI()
            configureWorkoutView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupFont()
        
        guard let dayOfWeekTrainingData else { return }
        
        dayOfWeekLabel.text = dayOfWeekTrainingData.dateOfWeek
        dayOfMonthLabel.text = dayOfWeekTrainingData.dateOfMonth
        
        let isToday = dayOfWeekTrainingData.dateIsToday()
        let textColor: UIColor = isToday ? AppColor.purple : .black
        
        dayOfWeekLabel.textColor = textColor
        dayOfMonthLabel.textColor = textColor
    }
    
    private func setupFont() {
        dayOfWeekLabel.font = AppFont.bold.withSize(12)
        dayOfMonthLabel.font = AppFont.regular.withSize(16)
    }
    
    // MARK: - Configure Workout View
    private func configureWorkoutView() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let dayOfWeekTrainingData,
              let assignments = dayOfWeekTrainingData.trainingData?.assignments,
              !assignments.isEmpty
        else {
            addEmptyView()
            return
        }
        
        for assignment in assignments {
            let workoutView = WorkoutView()
            workoutView.didTapWorkout = didTapWorkout
            workoutView.configure(
                isWorkoutPastDate: dayOfWeekTrainingData.isWorkoutPastDate(),
                isWorkoutFutureDate: dayOfWeekTrainingData.isWorkoutFutureDate(),
                assignment: assignment
            )
            stackView.addArrangedSubview(workoutView)
        }
    }
    
    // MARK: - Add Empty View
    private func addEmptyView() {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 72))
        stackView.addArrangedSubview(emptyView)
    }
}
