//
//  SearchViewModel.swift
//  m18
//
//  Created by Egor Naberezhnov on 03.04.2024.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var films: [FilmModel]? { get set }
    var updateView: (() -> Void )? { get set }
}
class SearchViewModel: SearchViewModelProtocol {
    var updateView: (() -> Void)?
    enum Action {
        case buttonTop100DidTap
        case buttonSearchDidTap(String)
    }
    enum State {
        case initial
        case loading
        case loaded([FilmModel])
        case error
    }
    var films: [FilmModel]?
    var networkManager: NetworkManager
    var stateChanged: ((State) -> Void)?
    private(set) var state: State = .initial {
        didSet {
            stateChanged?(state)
        }
    }
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    func initialState() {
        state = .initial
    }
    func sendAction(_ action: Action) {
        switch action {
        case .buttonSearchDidTap(let keyword):
            state = .loading
            networkManager.getSearchingFilms(keyword) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let films):
                    self.state = .loaded(films)
                    self.films = films
                    self.updateView?()
                case .failure:
                    self.state = .error
                }
            }
        case .buttonTop100DidTap:
            state = .loading
            networkManager.getTop100Films { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let films):
                    self.state = .loaded(films)
                    self.films = films
                    self.updateView?()
                case .failure:
                    self.state = .error
                }
            }
        }
    }
    func getF(_ number: Int, completion: @escaping (FilmIdModel) -> Void) {
        networkManager.getByIdFilms(number, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let film):
                completion(film)
            case .failure:
                self.state = .error
            }
        })
    }
}
