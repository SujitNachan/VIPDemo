//
//  MovieDetailInterface.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import Foundation

protocol MovieDetailViewControllerInterface: PresenterViewInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func updateMovieData(_ movieViewModel: MovieViewModel)
    func updateBookmarkButton(_ movieViewModel: MovieViewModel)
}

protocol MovieDetailViewInteractorInterface {
    func getMovieData()
    func bookmarkMovie(_ movieViewModel: MovieViewModel)
}

protocol MovieDetailViewPresenterInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func updateMovieData(_ movieViewModel: MovieViewModel)
    func updateBookmarkButton(_ movieViewModel: MovieViewModel)
}

protocol MovieDetailViewRouterInterface {
//    func navigateToDetailsScreen(homeCollectionViewModel: HomeCollectionViewModel)
}
