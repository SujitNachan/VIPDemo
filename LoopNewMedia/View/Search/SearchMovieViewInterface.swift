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
    func updateRatings(_ ratings: [RatingViewModel])
}

protocol SearchMovieViewInteractorInterface {
    func getRatings()
    func getMovies()
    func bookmarkMovie(at index: Int)
    func didSelectMovie(_ movie: StaffPicksViewModel)
    func searchMovieWith(title: String?)
    func didSelectRating(at index: Int)
}

protocol SearchMovieViewPresenterInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func reloadBookmarkCell(at index: Int)
    func updateMovies(_ movies: [StaffPicksViewModel])
    func updateRatings(_ ratings: [RatingViewModel])
}

protocol SearchMovieViewRouterInterface {
    func navigateToDetailsScreen(_ movie: Movie, bookmarkHandler: (() -> Void)?)
}
