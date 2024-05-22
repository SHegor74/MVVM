//
//  SearchConfigurator.swift
//  m18
//
//  Created by Egor Naberezhnov on 04.04.2024.
//

import Foundation

class DetailConfigurator {

    func configure(_ film: FilmIdModel) -> FilmDetailView {
        let detailVM = DetailViewModel()
        let filmDetailView = FilmDetailView(detailViewModel: detailVM)
        DispatchQueue.main.async {
            detailVM.film = film
        }
        return filmDetailView
    }
}
