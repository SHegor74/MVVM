//
//  KinopoiskModel.swift
//  m18
//
//  Created by Egor Naberezhnov on 17.02.2024.
//

import Foundation

// MARK: - Models for Task 1 & Task 2

class SearchingFilmsModel: Decodable {
    let films: [FilmModel]
}

struct FilmModel: Decodable {
    let filmId: Int
    let nameRu: String
    let posterUrl: String
}

class SearchingFilmsIdModel: Decodable {
    let film: FilmIdModel
}

// MARK: - Models for Task 3

struct FilmIdModel: Decodable {
    let nameRu: String?
    let nameOriginal: String?
    let posterUrl: String?
    let ratingKinopoisk: Float?
    let ratingImdb: Float?
    let year: Int?
    let filmLength: Int?
    let description: String?
}
