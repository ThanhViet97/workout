//
//  LocalFileData.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

enum StoredFile: String {
    case dayOfWeekTrainingDatas = "Day_Of_Week_Training_Datas_File"
}

final class LocalFileDataImpl: LocalFileData {

    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first ?? NSTemporaryDirectory()
    }
}

// MARK: - Save into document directory
extension LocalFileDataImpl {

    func saveData(_ data: Data, fileName: String) -> Bool {
        let path = documentsDirectory()
        return saveData(data, fileName: fileName, atPath: path)
    }

    func getData(with name: String) -> Data? {
        let path = getDataPath(with: name)
        return FileManager.default.contents(atPath: path)
    }
    
    private func saveData(_ data: Data, fileName: String, atPath path: String) -> Bool {
        let newPath = NSString(string: path).appendingPathComponent(fileName)
        FileManager.default.createFile(atPath: newPath, contents: nil, attributes: nil)
        if FileManager.default.isWritableFile(atPath: newPath) {
            do {
                try data.write(to: URL(fileURLWithPath: newPath))
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    private func getDataPath(with name: String) -> String {
        let path = documentsDirectory()
        let dataPath = NSString(string: path).appendingPathComponent(name)
        return dataPath
    }

    func removeFile(with name: String) {
        let path = getDataPath(with: name)
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {

            }
        }
    }
}

extension LocalFileDataImpl {
    func save(_ dayOfWeekTrainingDatas: [DayOfWeekTrainingData]?) {
        removeDayOfWeekTrainingDatasFileName()
        guard let dayOfWeekTrainingDatas = dayOfWeekTrainingDatas else {
            print("Delete dayOfWeekTrainingDatas successfull")
            return
        }
        do {
            let data = try PropertyListEncoder().encode(dayOfWeekTrainingDatas)
            let fileName = StoredFile.dayOfWeekTrainingDatas.rawValue
            let success = resolve(LocalFileData.self).saveData(data, fileName: fileName)
            if success {
                print("Save dayOfWeekTrainingDatas successful")
            } else {
                print("Save dayOfWeekTrainingDatas failed")
            }
        } catch {
            print("Save dayOfWeekTrainingDatas failed")
        }
       
    }
    
    func getDayOfWeekTrainingDatas() -> [DayOfWeekTrainingData]? {
        guard let saveDayOfWeekTrainingDatas = resolve(LocalFileData.self).getData(with: StoredFile.dayOfWeekTrainingDatas.rawValue) else {
            return nil
        }
        do {
            let result = try PropertyListDecoder().decode([DayOfWeekTrainingData].self, from: saveDayOfWeekTrainingDatas)
            return result
        } catch {
            return nil
        }
    }
    
    func removeDayOfWeekTrainingDatasFileName() {
        resolve(LocalFileData.self).removeFile(with: StoredFile.dayOfWeekTrainingDatas.rawValue)
    }
}
