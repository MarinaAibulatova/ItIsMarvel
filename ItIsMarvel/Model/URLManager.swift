//
//  URLManager.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 06.07.2021.
//

import Foundation
import CommonCrypto

struct URLManager {
    
    let publicKey = "5cd36a952d8f220fd346de48c6e20eeb"
    let privateKey = "cbd7f39722ed06a37fdf77844898db7e571ac69e"
    
    //MARK: - URL for characters/series
    func createUrl(with queryItems: [String: String], for path: String = "") -> URL? {
        
        let ts = createTs()
        let hash = createHash(with: ts)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.path = "/v1/public/characters"
        
        if !path.isEmpty {
            urlComponents.path += path
        }
        urlComponents.queryItems = setQuerryItems(with: queryItems)
        
        urlComponents.queryItems?.append(URLQueryItem(name: "ts", value: ts))
        urlComponents.queryItems?.append(URLQueryItem(name: "apikey", value: publicKey))
        urlComponents.queryItems?.append(URLQueryItem(name: "hash", value: hash))
        
        return urlComponents.url
    }
    
    //MARK: - Marvel hash - md5(ts+privateKey+publicKey)
    func createTs() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        let ts = formatter.string(from: today)
        return ts
    }
    func createHash(with ts: String) -> String {
        let message = ts + privateKey + publicKey
       
        return message.md5
    }
    
    func setQuerryItems(with parameters: [String: String]) -> [URLQueryItem] {
        let querryItems = parameters.map({ URLQueryItem(name: $0.key, value: $0.value)})
        return querryItems
    }
}

//MARK: - md5
extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
                       CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
                       return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
