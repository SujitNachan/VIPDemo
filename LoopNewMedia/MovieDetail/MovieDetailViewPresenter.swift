//
//  MovieDetailPresenter.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import Foundation

class MovieDetailViewPresenter: MovieDetailViewPresenterInterface {
    weak var viewController: MovieDetailViewControllerInterface?

    func updateSectionsData(_ movieSectionDetailViewModel: MovieSectionDetailViewModel) {
        viewController?.updateSectionsData(movieSectionDetailViewModel)
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
    
    func updateBookmarkButton(_ movieViewModel: MovieViewModel) {
        viewController?.updateBookmarkButton(movieViewModel)
    }
}
