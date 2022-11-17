//
//  SearchMovieViewController.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import UIKit

class SearchMovieViewController: UIViewController {
    private var movieTableView: UITableView?
    private var searchBar: UISearchBar?
    private var interactor: SearchMovieViewInteractorInterface?
    private var movies: [StaffPicksViewModel] = []
    
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
        // Do any additional setup after loading the view.
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
        let tableViewFrame = CGRect(origin: CGPoint(x: 0, y: 0 ), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height - (self.navigationController?.navigationBar.bounds.height ?? 0)))
        movieTableView = UITableView(frame: tableViewFrame)
        movieTableView?.separatorStyle = .none
        if let movieTableView = movieTableView {
            self.view.addSubview(movieTableView)
        }
        movieTableView?.backgroundColor = .clear
        movieTableView?.delegate = self
        movieTableView?.dataSource = self
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
        
        return cell
    }
}


extension SearchMovieViewController: SearchMovieViewControllerInterface {
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
