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
    func updateSectionsData(_ movieSectionDetailViewModel: MovieSectionDetailViewModel)
    func updateBookmarkButton(_ movieViewModel: MovieViewModel)
}

protocol MovieDetailViewInteractorInterface {
    func getSectionsData()
    func bookmarkMovie(_ movieViewModel: MovieViewModel)
}

protocol MovieDetailViewPresenterInterface {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(message: String)
    func updateSectionsData(_ movieSectionDetailViewModel: MovieSectionDetailViewModel)
    func updateBookmarkButton(_ movieViewModel: MovieViewModel)
}

protocol MovieDetailViewRouterInterface {
//    func navigateToDetailsScreen(homeCollectionViewModel: HomeCollectionViewModel)
}
