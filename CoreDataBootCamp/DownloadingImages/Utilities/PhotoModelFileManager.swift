
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
    
}
