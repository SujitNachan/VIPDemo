//
//  SearchMovieViewInterface.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import Foundation

protocol SearchMovieViewControllerInterface: PresenterViewInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func reloadBookmarkCell(at index: Int)
    func updateMovies(_ movies: [StaffPicksViewModel])
}

protocol SearchMovieViewInteractorInterface {
    func getMovies()
    func bookmarkMovie(at index: Int)
}

protocol SearchMovieViewPresenterInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func reloadBookmarkCell(at index: Int)
    func updateMovies(_ movies: [StaffPicksViewModel])
}

protocol SearchMovieViewRouterInterface {
//    func navigateToDetailsScreen(homeCollectionViewModel: HomeCollectionViewModel)
}
