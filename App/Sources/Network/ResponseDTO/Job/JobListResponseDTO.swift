import Foundation

struct JobListResponseDTO: Decodable {
    let id: Int
    let title: String
    let content: String
    let specialNote: String
    let tags: [String]
    let urls: [String]
    
    var toDomain: JobListEntity {
        return JobListEntity(
            id: id,
            title: title,
            content: content,
            specialNote: specialNote,
            tags: tags,
            urls: urls
        )
    }
}
