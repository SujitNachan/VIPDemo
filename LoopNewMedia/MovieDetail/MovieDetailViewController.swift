//
//  MovieDetailViewController.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private var interactor: MovieDetailViewInteractorInterface?
    private var movieTableView: UITableView?
    private var movie: Movie?
    
    init(interactor: MovieDetailViewInteractorInterface) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//        navigationItem.title = "Detail"
        setupNavigationBar()
        setupUI()
        interactor?.getMovieData()
    }
    
    private func setupNavigationBar() {
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "Close"), for: .normal)
        closeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        let closeButtonItem = UIBarButtonItem(customView: closeButton)
        closeButtonItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButtonItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let bookmarkButton = UIButton(type: .custom)
        bookmarkButton.setImage(UIImage(named: "BookmarkBlack"), for: .normal)
        bookmarkButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        bookmarkButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 26, bottom: 5, right: 20)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonClicked), for: .touchUpInside)
        let bookmarkButtonItem = UIBarButtonItem(customView: bookmarkButton)
        bookmarkButtonItem.customView?.widthAnchor.constraint(equalToConstant: 60).isActive = true
        bookmarkButtonItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.navigationItem.setRightBarButtonItems([closeButtonItem, bookmarkButtonItem], animated: false)
        
    }
    
    private func setupUI() {
        movieTableView = UITableView(frame: self.view.bounds)
        movieTableView?.separatorStyle = .none
        if let movieTableView = movieTableView {
            self.view.addSubview(movieTableView)
        }
        movieTableView?.backgroundColor = .clear
        movieTableView?.delegate = self
        movieTableView?.dataSource = self
        movieTableView?.register(MoviePosterTitleTableViewCell.self)
    }
    
    @objc private func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc private func bookmarkButtonClicked() {
        
    }
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {
    func updateMovieData(_ movie: Movie) {
        self.movie = movie
        self.movieTableView?.reloadData()
    }
    
    func showActivityIndicator() {
    }
    
    func hideActivityIndicator() {
    }
    
    func showAlertView(message: String) {
        showAlertViewWithStyle(title: "Error", message: message, actionTitles: ["Ok"], handler: [])
    }
}


extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviePosterCell: MoviePosterTitleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        moviePosterCell.cellData = self.movie
        return moviePosterCell
    }
}
