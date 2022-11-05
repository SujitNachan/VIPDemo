//
//  HomeViewPresenter.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import Foundation
class HomeViewPresenter {
    weak var viewController: HomeViewControllerInterface?
}

extension HomeViewPresenter: HomeViewPresenterInterface {
    func bookmarkStaffPicks(at index: Int) {
        viewController?.bookmarkStaffPicks(at: index)
    }
    
    func update(staffPicks: [StaffPicksViewModel]) {
        viewController?.update(staffPicks: staffPicks)
    }
    
    func update(movies: [YourFavoriteMovieViewModel]) {
        viewController?.update(movies: movies)
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
