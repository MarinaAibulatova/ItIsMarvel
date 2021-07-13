//
//  MarvelRequestManager.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 06.07.2021.
//

import Foundation

protocol MarvelCharactersManagerDelegate: AnyObject {
    func didFinishedWithError(error: String)
    func didFinishedFetchCharacters(result: [CharacterResult])
}

class MarvelCharactersManager{
   
    //MARK: - variables
    var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    weak var delegate: MarvelCharactersManagerDelegate?
    
    //MARK: - Fetch characters
    func fetchCharacters(with sortParameters: [String: String] = [:], limit: Int, offset: Int) {
        var parameters = ["limit": String(limit), "offset": String(offset)]
        
        if !sortParameters.isEmpty {
            for p in sortParameters {
                parameters[p.key] = p.value
            }
        }
        
        let urlManager = URLManager()
        let url = urlManager.createUrl(with: parameters)
        let requestManager = MarvelRequestManager(url: url)
        let getCharactersRequest = requestManager.createGetRequest()
        
        guard getCharactersRequest != nil else {
            delegate?.didFinishedWithError(error: "error")
            return
        }
        
        let task = session.dataTask(with: getCharactersRequest!) { (data, responce, error) in
            if error != nil {
                self.delegate?.didFinishedWithError(error: error!.localizedDescription)
            }
                
            if let httpResponce = responce as? HTTPURLResponse {
                if (200...299).contains(httpResponce.statusCode) {
                    if let safeData = data {
                        let parser = JSONParserManager(data: safeData)
                        let results = parser.parseJSONCharacters()
                        
                        if let notNilResults = results {
                            self.delegate?.didFinishedFetchCharacters(result: notNilResults)
                        }else {
                            self.delegate?.didFinishedWithError(error: "error")
                        }
                    }
                }
            }
        }
        task.resume()
    }
 
}
