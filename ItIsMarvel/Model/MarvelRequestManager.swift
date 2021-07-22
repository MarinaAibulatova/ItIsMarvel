//
//  MarvelRequestManager.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 12.07.2021.
//

import Foundation

struct MarvelRequestManager{
    let url: URL?
    
    func createGetRequest() -> URLRequest? {
        if let url = url {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            request.httpMethod = "GET"
            
            return request
        }else {
            return nil
        }
    }
}

struct RequestStaticParameters {
    static let limit: Int = 20
    static var offsetCharacters: Int = 0
    static var offsetSeries: Int = 0
    static var sortValue: String = "name"
}
