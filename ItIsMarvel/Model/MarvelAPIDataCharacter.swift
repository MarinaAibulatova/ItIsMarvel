//
//  APIModel.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 06.07.2021.
//

import Foundation

//MARK: - API Model Character
struct MarvelAPIDataCharacter: Codable {
    let code: Int? //http status code
    let attributionText: String? //title
    let data: CharacterDataContainer?
}

struct CharacterDataContainer: Codable {
    let offset: Int? //number of skipped results
    let limit: Int? // result limit
    let count: Int? //count of results
    let results: [CharacterResult]? //list of characters
}

struct CharacterResult: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: ImageMarvel? // image for this character
    
}

//MARK: - Image for character
struct ImageMarvel: Codable {
    enum CodingKeys: String, CodingKey {
        case path
        case extensionString = "extension"
    }
    
    let path: String?
    let extensionString: String?
}




