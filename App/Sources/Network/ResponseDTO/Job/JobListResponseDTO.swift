import Foundation

struct JobListResponseDTO: Decodable {
    let id: Int
    let title: String
    let content: String
    let specialNote: String
    let tag: [String]
    let urls: [String]
    
    var toDomain: JobListEntity {
        return JobListEntity(
            id: id,
            title: title,
            content: content,
            specialNote: specialNote,
            tag: tag,
            urls: urls
        )
    }
}
