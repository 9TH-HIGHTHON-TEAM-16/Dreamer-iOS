import Foundation

struct JobListResponseDTO: Decodable {
    let title: String
    let content: String
    let specialNote: String
    let tag: [String]
    let urls: [String]
    
    var toDomain: JobListEntity {
        return JobListEntity(
            title: title,
            content: content,
            specialNote: specialNote,
            tag: tag,
            urls: urls
        )
    }
}
