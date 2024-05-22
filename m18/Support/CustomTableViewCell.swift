//
//  CustomTableViewCell.swift
//  m18
//
//  Created by Egor Naberezhnov on 11.03.2024.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    // MARK: - Properties
    let networkManager = NetworkManager()
    static let reusedId = "CustomTableViewCell"
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var kinopoiskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Kinopoisk"
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - data service
    func update(_ film: FilmModel) {
        self.posterImageView.kf.setImage(with: URL(string: film.posterUrl))
        self.kinopoiskLabel.text = film.nameRu
    }
}

// MARK: - setup & constraints

extension CustomTableViewCell {
    func setupViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(kinopoiskLabel)
        selectionStyle = .none
    }
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.left.top.equalTo(contentView).inset(5)
            make.centerY.equalTo(contentView)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        kinopoiskLabel.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(15)
            make.top.bottom.equalTo(posterImageView)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(posterImageView.snp.centerY)
        }
    }
}
