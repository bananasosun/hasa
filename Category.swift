import Foundation

struct CategoryResponse: Codable {
    let meals: [Category]
}

struct Category: Codable, Identifiable {
    let id = UUID()
    let strCategory: String

    enum CodingKeys: String, CodingKey {
        case strCategory
    }
}
