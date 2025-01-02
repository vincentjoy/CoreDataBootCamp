import Foundation

struct PhotoModel: Identifiable, Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
