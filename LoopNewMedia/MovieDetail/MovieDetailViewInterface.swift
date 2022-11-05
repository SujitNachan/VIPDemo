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
    func updateMovieData(_ movie: Movie)
}

protocol MovieDetailViewInteractorInterface {
    func getMovieData()
}

protocol MovieDetailViewPresenterInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func updateMovieData(_ movie: Movie)
}

protocol MovieDetailViewRouterInterface {
//    func navigateToDetailsScreen(homeCollectionViewModel: HomeCollectionViewModel)
}
