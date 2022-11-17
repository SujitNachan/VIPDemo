//
//  SearchMovieViewPresenter.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import Foundation

class SearchMovieViewPresenter {
    weak var viewController: SearchMovieViewControllerInterface?
}

extension SearchMovieViewPresenter: SearchMovieViewPresenterInterface {
    func updateMovies(_ movies: [StaffPicksViewModel]) {
        viewController?.updateMovies(movies)
    }
    
    func reloadBookmarkCell(at index: Int) {
        viewController?.reloadBookmarkCell(at: index)
    }
    
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
