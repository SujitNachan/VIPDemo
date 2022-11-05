//
//  MovieDetailPresenter.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import Foundation

class MovieDetailViewPresenter: MovieDetailViewPresenterInterface {
    func updateMovieData(_ movie: Movie) {
        viewController?.updateMovieData(movie)
    }
    
    weak var viewController: MovieDetailViewControllerInterface?
    
    func showActivityIndicator() {
        viewController?.showActivityIndicator()
    }
    
    func hideActivityIndicator() {
        viewController?.hideActivityIndicator()
    }
    
    func showAlertView(message: String) {
        viewController?.showAlertView(message: message)
    }
}
