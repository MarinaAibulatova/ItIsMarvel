//
//  JSONParserManager.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 06.07.2021.
//

import Foundation

struct JSONParserManager{

    //MARK: - variables
    var data: Data
    let decoder: JSONDecoder
    
    init(data: Data) {
        self.data = data
        self.decoder = JSONDecoder()
    }
    
    func parseJSONCharacters() -> [CharacterResult]? {
        do {
            let decoderData = try decoder.decode(MarvelAPIDataCharacter.self, from: data)
            if let results = decoderData.data?.results {
                return results
            }else {
                return nil
            }
        }catch {
            return nil
        }
    }
}
