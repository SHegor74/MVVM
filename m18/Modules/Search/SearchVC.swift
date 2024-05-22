//
//  ViewController.swift
//  m18
//
//  Created by Egor Naberezhnov on 06.02.2024.
//
import UIKit
import SnapKit

class SearchVC: UIViewController, UISearchBarDelegate {
    // MARK: - Properties
    var searchViewModel: SearchViewModel?
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Введите запрос"
        searchBar.tintColor = .clear
        searchBar.barTintColor = .white
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.delegate = self
        return searchBar
    }()
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поиск", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    lazy var getPopularFilmsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Популярные фильмы", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    lazy var responseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    lazy var responseTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reusedId)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        searchViewModel?.updateView = { [weak self] in
            self?.responseTableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
        action()
    }
    // MARK: - Button tapped action
    func action() {
        searchButton.addTarget(self, action: #selector(getRequestFilms), for: .touchUpInside)
        getPopularFilmsButton.addTarget(self, action: #selector(getTop100Films), for: .touchUpInside)
    }
    @objc func getRequestFilms() {
        let request = searchBar.text ?? ""
        activityIndicator.startAnimating()
        searchViewModel?.sendAction(.buttonSearchDidTap(request))
        DispatchQueue.main.async {
            self.responseLabel.text = "Поиск по запросу: \(request)"
            self.searchBar.text = ""
        }
    }
    @objc func getTop100Films() {
        searchViewModel?.sendAction(.buttonTop100DidTap)
        activityIndicator.startAnimating()
        DispatchQueue.main.async {
            self.responseLabel.text = "Популярные фильмы"
            self.searchBar.text = ""
        }
    }
    func filmCellSelected(_ filmId: Int) {
        searchViewModel?.getF(filmId) { film in
            let detailVC = DetailConfigurator().configure(film)
            self.present(detailVC, animated: true)
        }
    }
}
// MARK: - DataSource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel?.films?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CustomTableViewCell()
        if let film = searchViewModel?.films?[indexPath.row] {
            cell.update(film)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let filmId = searchViewModel?.films?[indexPath.row].filmId {
            filmCellSelected(filmId)
        }
    }
}
// MARK: - Navigation
extension SearchVC {
    func navigateToDetailScreen(_ film: FilmIdModel) {
        DispatchQueue.main.async {
            print(Thread.current)
            let detailVC = DetailConfigurator().configure(film)
            self.present(detailVC, animated: true)
        }
    }
}
// MARK: - setup & constraints
extension SearchVC {
    func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(searchButton)
        view.addSubview(getPopularFilmsButton)
        view.addSubview(responseLabel)
        view.addSubview(responseTableView)
        view.addSubview((activityIndicator))
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
    }
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        getPopularFilmsButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        responseLabel.snp.makeConstraints { make in
            make.top.equalTo(getPopularFilmsButton.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(17)
            make.height.equalTo(30)
        }
        responseTableView.snp.makeConstraints { make in
            make.top.equalTo(responseLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(15)
        }
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
