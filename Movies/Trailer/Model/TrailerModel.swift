// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct TrailerModel: Decodable {
    let id: Int
    let results: [TrailerDetailModel]
}

// MARK: - Result
struct TrailerDetailModel: Decodable {
    let id: String
    let iso639_1: String
    let iso3166_1: String
    let key, name: String
    let site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}


