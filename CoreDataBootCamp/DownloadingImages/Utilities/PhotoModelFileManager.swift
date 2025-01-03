
import Foundation
import SwiftUI

final class PhotoModelFileManager {
    
    static let shared = PhotoModelFileManager()
    private let folderName: String = "downloaded_photos"
    private init() { }
    
    private func createFolderIfNeeded() throws {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Create folder!")
            } catch {
                print("Error creating folder - \(error.localizedDescription)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        let folderURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let folderPath = folderURL?.appendingPathComponent(folderName)
        return folderPath
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folderPath = getFolderPath() else {
            return nil
        }
        let imagePath = folderPath.appendingPathComponent(key + ".png")
        return imagePath
    }
    
    func add(key: String, value: UIImage) {
        guard let data = value.pngData(), let url = getImagePath(key: key) else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch {
            print("Error saving to file manager - \(error.localizedDescription)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard let url = getImagePath(key: key), FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
}
