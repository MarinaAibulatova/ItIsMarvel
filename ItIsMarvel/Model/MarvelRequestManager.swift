//
//  MarvelRequestManager.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 06.07.2021.
//

import Foundation

protocol MarvelRequestManagerDelegate: AnyObject {
    func didFinishedWithError(error: String)
    func didFinishedFetchCharacters(result: [CharacterResult]?)
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
    func fetchCharacters() {
        let parameters = ["limit": "20"]
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
                        self.delegate?.didFinishedFetchCharacters(result: results)
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
           // request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            request.httpMethod = "GET"
            
            return request
        }else {
            return nil
        }
    }
    
    


    
    
    

    
    
    

}
