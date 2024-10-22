//
//  LocalFileData.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

protocol LocalFileData {
    func saveData(_ data: Data, fileName: String) -> Bool
    func getData(with name: String) -> Data?
    func removeFile(with name: String)
    func save(_ dayOfWeekTrainingDatas: [DayOfWeekTrainingData]?)
    func getDayOfWeekTrainingDatas() -> [DayOfWeekTrainingData]?
    func removeDayOfWeekTrainingDatasFileName()
}
