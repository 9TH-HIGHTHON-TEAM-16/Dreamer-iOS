import Foundation

struct DefaultResponseDTO<T: Decodable>: Decodable {
    let status: Int
    let data: T
}
