//
//  DetailViewModel.swift
//  m18
//
//  Created by Egor Naberezhnov on 08.04.2024.
//

import Foundation

class DetailViewModel {
    // MARK: - Propeties
    var film: FilmIdModel? {
        didSet {
            guard let film else { return }
            onFilmChanged?(film)
        }
    }
    var onFilmChanged: ((FilmIdModel) -> Void)?
}
