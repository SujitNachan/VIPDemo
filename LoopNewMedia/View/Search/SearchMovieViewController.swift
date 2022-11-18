//
//  SearchMovieViewController.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import UIKit



class SearchMovieViewController: UIViewController {
    private var ratingCollectionView: UICollectionView?
    private var movieTableView: UITableView?
    private var searchBar: UISearchBar?
    private var interactor: SearchMovieViewInteractorInterface?
    private var movies: [StaffPicksViewModel] = []
    private var ratings: [RatingViewModel] = []
    private var navigationBarHeight: CGFloat {
        navigationController?.navigationBar.frame.maxY ?? 80
    }
    
    init(interactor: SearchMovieViewInteractorInterface) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.1000831202, green: 0.1472782791, blue: 0.1932071447, alpha: 1)
        setupUI()
        interactor?.getMovies()
        interactor?.getRatings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.setHidesBackButton(false, animated: false)
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        ratingCollectionView = UICollectionView(frame: CGRect(x: 30, y: navigationBarHeight, width: self.view.bounds.width-60, height: 56), collectionViewLayout: layout)
        if let ratingCollectionView = ratingCollectionView {
            self.view.addSubview(ratingCollectionView)
        }
        ratingCollectionView?.showsHorizontalScrollIndicator = false
        ratingCollectionView?.backgroundColor = .clear
        ratingCollectionView?.delegate = self
        ratingCollectionView?.dataSource = self
        ratingCollectionView?.register(RatingCollectionViewCell.self)
        let tableViewFrame = CGRect(origin: CGPoint(x: 0, y: navigationBarHeight + 56), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height - (self.navigationController?.navigationBar.bounds.height ?? 0)))
        movieTableView = UITableView(frame: tableViewFrame)
        movieTableView?.separatorStyle = .none
        if let movieTableView = movieTableView {
            self.view.addSubview(movieTableView)
        }
        movieTableView?.backgroundColor = .clear
        movieTableView?.delegate = self
        movieTableView?.dataSource = self
        movieTableView?.keyboardDismissMode = .onDrag
        movieTableView?.register(StaffPicksTableViewCell.self)
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width-60, height: 48))
        if let textField = searchBar?.value(forKey: "searchField") as? UITextField {
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonClicked))
            imageView.addGestureRecognizer(tapGesture)
            imageView.isUserInteractionEnabled = true
            imageView.image = UIImage(named: "LeftArrow")
            imageView.center = leftView.center
            leftView.addSubview(imageView)
            textField.leftView = leftView
            textField.textColor = .white
            textField.tintColor = .white
            textField.backgroundColor = #colorLiteral(red: 0.1860546768, green: 0.2572888732, blue: 0.3237377405, alpha: 1)
            textField.setShadow()
            textField.font = UIFont.SFProDisplay(.medium, size: 14)
        }
        searchBar?.placeholder = "Search all movies"
        searchBar?.backgroundColor = .clear
        searchBar?.layoutIfNeeded()
        searchBar?.delegate = self
        navigationItem.titleView = searchBar
    }
    
    @objc private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StaffPicksTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.celldata = movies[indexPath.row]
        cell.bookmarkHandler = { [unowned self] in
            self.interactor?.bookmarkMovie(at: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectMovie(movies[indexPath.row])
    }
}


extension SearchMovieViewController: SearchMovieViewControllerInterface {
    func updateRatings(_ ratings: [RatingViewModel]) {
        self.ratings = ratings
        self.ratingCollectionView?.reloadData()
    }
    
    func updateMovies(_ movies: [StaffPicksViewModel]) {
        self.movies = movies
        self.movieTableView?.reloadData()
    }
    
    func reloadBookmarkCell(at index: Int) {
        self.movieTableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func showActivityIndicator() {
    }
    
    func hideActivityIndicator() {
    }
    
    func showAlertView(message: String) {
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.interactor?.searchMovieWith(title: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension SearchMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ratings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ratingCell: RatingCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        ratingCell.configureCell(data: self.ratings[indexPath.row])
        return ratingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rating = 5 - indexPath.row
        let width: CGFloat = CGFloat((rating * 12) + 20)
        let height: CGFloat = 12 + 16
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectRating(at: indexPath.row)
    }
}
