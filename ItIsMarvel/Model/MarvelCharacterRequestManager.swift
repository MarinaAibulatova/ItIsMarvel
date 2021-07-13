//
//  MarvelCharacterRequestManager.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 12.07.2021.
//

import Foundation

protocol MarvelCharacterManagerDelegate: AnyObject {
    func didFinishedWithError(error: String)
    func didFinishedFetchCharacter(result: CharacterResult)
    func didFinishedFetchSeries(result: [Series])
}

class MarvelCharacterManager {
    
    //MARK: - variables
    var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
    
    weak var delegate: MarvelCharacterManagerDelegate?
    
    //MARK: - Fetch character
    func fetchCharacter(with id: Int?, limit: Int, offset: Int) {
        if let _ = id {
            let parameters = ["limit": String(limit), "offset": String(offset)]
          
            let urlManager = URLManager()
            let url = urlManager.createUrl(with: parameters, for: "/\(id!)")
            let requestManager = MarvelRequestManager(url: url)
            let getCharacterRequest = requestManager.createGetRequest()
            
            guard getCharacterRequest != nil else {
                delegate?.didFinishedWithError(error: "error")
                return
            }
            
            let task = session.dataTask(with: getCharacterRequest!) { (data, responce, error) in
                if error != nil {
                    self.delegate?.didFinishedWithError(error: error!.localizedDescription)
                }
                    
                if let httpResponce = responce as? HTTPURLResponse {
                    if (200...299).contains(httpResponce.statusCode) {
                        if let safeData = data {
                            let parser = JSONParserManager(data: safeData)
                            let results = parser.parseJSONCharacter()
                            
                            if let notNilResults = results {
                                self.delegate?.didFinishedFetchCharacter(result: notNilResults)
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
    
    //MARK: - Fetch series
    func fetchSeries(with id: Int?, limit: Int, offset: Int) {
        if let _ = id {
            let parameters = ["limit": String(limit), "offset": String(offset)]
          
            let urlManager = URLManager()
            let url = urlManager.createUrl(with: parameters, for: "/\(id!)/series")
            let requestManager = MarvelRequestManager(url: url)
            let getSeriesRequest = requestManager.createGetRequest()
            
            guard getSeriesRequest != nil else {
                delegate?.didFinishedWithError(error: "error")
                return
            }
            
            let task = session.dataTask(with: getSeriesRequest!) { (data, responce, error) in
                if error != nil {
                    self.delegate?.didFinishedWithError(error: error!.localizedDescription)
                }
                
                if let httpResponce = responce as? HTTPURLResponse {
                    if (200...299).contains(httpResponce.statusCode) {
                        if let safeData = data {
                            let parser = JSONParserManager(data: safeData)
                            let results = parser.parseJSONSeries()
                            
                            if let notNilResults = results {
                                self.delegate?.didFinishedFetchSeries(result: notNilResults)
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
}
