//
//  HomeViewInterface.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import Foundation
protocol PresenterViewInterface: AnyObject {
    
}

protocol HomeViewControllerInterface: PresenterViewInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func update(staffPicks: [StaffPicksViewModel])
    func update(movies: [TableViewCellWithCollectionViewViewModel])
    func bookmarkStaffPicks(at index: Int)
}

protocol HomeViewInteractorInterface {
    func fetchMovies()
    func fetchStaffPicks()
    func movieDidSelect(yourFavoriteMovieViewModel: TableViewCellWithCollectionViewViewModel)
    func staffPicksDidSelect(staffPicksViewModel: StaffPicksViewModel)
    func bookmarkStaffPicks(at index: Int)
    func cancelDataTask()
    func routeToSearchScreen()
}

protocol HomeViewPresenterInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func update(staffPicks: [StaffPicksViewModel])
    func update(movies: [TableViewCellWithCollectionViewViewModel])
    func bookmarkStaffPicks(at index: Int)
}

protocol HomeViewRouterInterface {
    func navigateToMovieDetailScreen(movie: Movie, bookmarkHandler: (() -> Void)?)
    func navigateToSearchMovieScreen(movies: [Movie])
}
