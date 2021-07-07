//
//  MarvelAPIDataSeries.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 06.07.2021.
//

import Foundation

//MARK: - MarvelAPIDataSeries
struct MarvelAPIDataSeries: Codable {
    let code: Int? //http status code
    let attributionText: String? //title
    let data: SeriesDataContainer?
}

struct SeriesDataContainer: Codable {
    let offset: Int? //number of skipped results
    let limit: Int? // result limit
    let count: Int? //count of results
    let results: [Series]? //list of series
}

struct Series: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let thumbnail: ImageMarvel?
}



