//
//  FilmDetailViewController.swift
//  m18
//
//  Created by Egor Naberezhnov on 11.03.2024.
//

import UIKit
import Kingfisher

class FilmDetailView: UIViewController {
    // MARK: - Propeties
    var detailViewModel: DetailViewModel
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var kinopoiskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "Kinopoisk"
        return label
    }()
    lazy var kinopoiskRatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "rating"
        return label
    }()
    lazy var imdbLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "IMDB"
        return label
    }()
    lazy var imdbRatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "rating"
        return label
    }()
    lazy var ratingStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalCentering
        stack.axis = .vertical
        return stack
    }()
    lazy var nameRuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "NameRu"
        label.numberOfLines = 0
        return label
    }()
    lazy var nameEnLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "NameEn"
        label.numberOfLines = 0
        return label
    }()
    lazy var nameStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalCentering
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .boldSystemFont(ofSize: 20)
        return textView
    }()
    lazy var yearHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Год производства"
        return label
    }()
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "2023"
        return label
    }()
    lazy var yearStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
        lazy var durationHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Продолжительность"
        return label
    }()
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "180 мин."
        return label
    }()
        lazy var durationStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
        lazy var supportStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    init(detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        observe()
    }
    // MARK: - UPDATE UI
    func observe() {
        detailViewModel.onFilmChanged = { film in
            self.descriptionTextView.text = film.description
            self.durationLabel.text = "\(film.filmLength ?? 0)"
            self.imdbRatingLabel.text = "\(film.ratingImdb ?? 0.0)"
            self.kinopoiskRatingLabel.text = "\(film.ratingKinopoisk ?? 0.0)"
            self.nameRuLabel.text = film.nameRu
            self.nameEnLabel.text = film.nameOriginal
            self.yearLabel.text = "\(film.year ?? 0)"
            self.posterImageView.kf.setImage(with: URL(string: film.posterUrl ?? ""))
        }
    }
}
// MARK: - setup & constraints
extension FilmDetailView {
    func setupViews() {
        view.addSubview(posterImageView)
        view.addSubview(ratingStack)
        ratingStack.addArrangedSubview(kinopoiskLabel)
        ratingStack.addArrangedSubview(kinopoiskRatingLabel)
        ratingStack.addArrangedSubview(imdbLabel)
        ratingStack.addArrangedSubview(imdbRatingLabel)
        view.addSubview(nameStack)
        nameStack.addArrangedSubview(nameRuLabel)
        nameStack.addArrangedSubview(nameEnLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(supportStack)
        supportStack.addArrangedSubview(yearStack)
        supportStack.addArrangedSubview(durationStack)
        yearStack.addArrangedSubview(yearHeaderLabel)
        yearStack.addArrangedSubview(yearLabel)
        durationStack.addArrangedSubview(durationHeaderLabel)
        durationStack.addArrangedSubview(durationLabel)
        view.backgroundColor = .white
    }
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(270)
            make.width.equalTo(200)
        }
        ratingStack.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(15)
            make.top.equalToSuperview().inset(100)
            make.right.equalToSuperview().inset(35)
            make.bottom.equalTo(posterImageView.snp.bottom)
        }
        nameStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(ratingStack.snp.bottom).offset(30)
        }
        descriptionTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(nameStack.snp.bottom).offset(30)
            make.bottom.equalTo(supportStack.snp.top).offset(-20)
        }
        supportStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(100)
        }
    }
}
