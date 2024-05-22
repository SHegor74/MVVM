//
//  SearchConfigurator.swift
//  m18
//
//  Created by Egor Naberezhnov on 04.04.2024.
//

import Foundation

class SearchConfigurator {
    func configure() -> SearchVC {
        let searchView = SearchVC()
        let searchViewModel = SearchViewModel(networkManager: NetworkManager())
        let networkManager = NetworkManager()
        searchView.searchViewModel = searchViewModel
        searchViewModel.networkManager = networkManager
        return searchView
    }
}
