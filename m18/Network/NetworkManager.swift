//
//  KinopoiskManager.swift
//  m18
//
//  Created by Egor Naberezhnov on 10.02.2024.
//

import Foundation
import UIKit

class NetworkManager {
    let apiKey = "268c3fb1-a854-4012-9ce1-6691ca6aa1b7"
    private let networkClient: NetworkRouting
    private let decoder: JSONDecoder
    init(networkClient: NetworkRouting = NetworkClient(), decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    // MARK: - NetworkService for Task 1
    func getSearchingFilms(_ keyword: String = "", completion: @escaping (Result<[FilmModel], Error>) -> Void) {
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(keyword)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        networkClient.fetch(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let films = try self.decoder.decode(SearchingFilmsModel.self, from: data)
                    var filmsArray = [FilmModel]()
                    films.films.forEach { item in
                        let filmId = item.filmId
                        let nameRu = item.nameRu
                        let posterUrl = item.posterUrl
                        let newItem = FilmModel(filmId: filmId,
                                                nameRu: nameRu,
                                                posterUrl: posterUrl)
                        filmsArray.append(newItem)
                    }
                    DispatchQueue.main.async {
                        completion(.success(filmsArray))
                    }
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    // MARK: - NetworkService for Task 2
    func getTop100Films(completion: @escaping (Result<[FilmModel], Error>) -> Void) {
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        networkClient.fetch(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let filmsResponse = try self.decoder.decode(SearchingFilmsModel.self, from: data)
                    var filmsArray = [FilmModel]()
                    filmsResponse.films.forEach { item in
                        let filmId = item.filmId
                        let nameRu = item.nameRu
                        let posterUrl = item.posterUrl
                        let newItem = FilmModel(filmId: filmId,
                                                nameRu: nameRu,
                                                posterUrl: posterUrl)
                        filmsArray.append(newItem)
                    }
                    DispatchQueue.main.async {
                        print("->", filmsArray)
                        completion(.success(filmsArray))
                    }
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    // MARK: - NetworkService for Task 3
    func getByIdFilms(_ id: Int = 0, completion: @escaping (Result<FilmIdModel, Error>) -> Void) {
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        networkClient.fetch(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let film = try self.decoder.decode(FilmIdModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(film))
                    }
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
