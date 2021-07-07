//
//  MarvelRequestManager.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 06.07.2021.
//

import Foundation

protocol MarvelRequestManagerDelegate: AnyObject {
    func didFinishedWithError(error: String)
    func didFinishedFetchCharacters(result: [CharacterResult])
}

class MarvelRequestManager{
   
    //MARK: - variables
    var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    weak var delegate: MarvelRequestManagerDelegate?
    
    //MARK: - Fetch characters
    func fetchCharacters(with sortParameters: [String: String] = [:]) {
        var parameters = ["limit": "20", "offset": String(Offset.skipNumber)]
        
        if !sortParameters.isEmpty {
            for p in sortParameters {
                parameters[p.key] = p.value
            }
            Offset.skipNumber = 0
        }
        
        let urlManager = URLManager()
        let url = urlManager.createUrl(with: parameters)
        let getCharactersRequest = createGetRequest(with: url)
        
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
                            Offset.skipNumber += notNilResults.count
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
    
    //MARK: - Fetch character
    func fetchCharacter() {
        
    }
    
    //MARK: - Fetch series
    func fetchSeries() {
        
    }
    
    //MARK: - Request manager
    func createGetRequest(with url: URL?) -> URLRequest? {
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
