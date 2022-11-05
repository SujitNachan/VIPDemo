//
//  ViewController.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import UIKit

enum HomeViewSections: Int, CaseIterable {
    case searchButton
    case yourFavorites
    case ourStaff
}

class HomeViewController: UIViewController {
    private var movieTableView: UITableView?
    var interactor: HomeViewInteractorInterface?
    private var staffPicks: [StaffPicksViewModel] = []
    private var yourFavoriteMovies: [YourFavoriteMovieViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        interactor?.fetchStaffPicks()
        interactor?.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        movieTableView?.register(StaffPicksTableViewCell.self)
        movieTableView?.register(FavoriteMovieCell.self)
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case HomeViewSections.searchButton.rawValue:
            return 0
        case HomeViewSections.ourStaff.rawValue:
            return self.staffPicks.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case HomeViewSections.ourStaff.rawValue:
            let staffCell: StaffPicksTableViewCell =  tableView.dequeueReusableCell(for: indexPath)
            staffCell.celldata = self.staffPicks[indexPath.row]
            staffCell.bookmarkHandler = { [unowned self] in
                self.interactor?.bookmarkStaffPicks(at: indexPath.row)
            }
            return staffCell
        default:
            
            let movieCell: FavoriteMovieCell = tableView.dequeueReusableCell(for: indexPath)
            movieCell.cellData = self.yourFavoriteMovies
            movieCell.movieSelectHandler = { [unowned self] yourFavoriteMovie in
                self.interactor?.movieDidSelect(yourFavoriteMovieViewModel: yourFavoriteMovie)
            }
            return movieCell
        }
        
        
    }
}

extension HomeViewController: UITableViewDelegate {
    @objc func searchButtonClicked() {
        print("navigate to search screen")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == HomeViewSections.ourStaff.rawValue {
            interactor?.staffPicksDidSelect(staffPicksViewModel: staffPicks[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel(frame: CGRect(x: 30, y: 8, width: 320, height: 20))
        
        myLabel.font = UIFont.SFProDisplay(.regular, size: 12)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        guard let boldfont = UIFont.SFProDisplay(.bold, size: 12) else {
            return nil
        }
        let headerView = UIView()
        
        
        switch section {
        case HomeViewSections.searchButton.rawValue:
            let headerView = HeaderViewWithButton(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 48)).with { [weak self] headerViewObj in
                guard let self = self else { return }
                headerViewObj.searchButton.addTarget(self, action: #selector(self.searchButtonClicked), for: .touchUpInside)
            }
            return headerView
        case HomeViewSections.yourFavorites.rawValue:
            myLabel.changeFont(ofText: "FAVORITES", with: boldfont)
            myLabel.textColor = .black
        case HomeViewSections.ourStaff.rawValue:
            myLabel.changeFont(ofText: "STAFF PICKS", with: boldfont)
            myLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        default:
            break
        }
        headerView.addSubview(myLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case HomeViewSections.yourFavorites.rawValue:
            return "YOUR FAVORITES"
        case HomeViewSections.ourStaff.rawValue:
            return "OUR STAFF PICKS"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case HomeViewSections.searchButton.rawValue:
            return 48
        default:
            return 25
        }
    }
}

extension HomeViewController: HomeViewControllerInterface {
    func bookmarkStaffPicks(at index: Int) {
        self.staffPicks[index].bookmarkStatus = !(self.staffPicks[index].bookmarkStatus ?? false)
        
        self.movieTableView?.reloadRows(at: [IndexPath(row: index, section: HomeViewSections.ourStaff.rawValue)], with: .automatic)
    }
    
    func update(movies: [YourFavoriteMovieViewModel]) {
        self.yourFavoriteMovies = movies
        self.movieTableView?.reloadData()
    }
    
    func update(staffPicks: [StaffPicksViewModel]) {
        self.staffPicks = staffPicks
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
