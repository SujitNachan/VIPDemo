//
//  HomeViewRouter.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import UIKit

class HomeViewRouter {
    weak var viewController: UIViewController?
}

extension HomeViewRouter: HomeViewRouterInterface {
    func navigateToMovieDetailScreen(movie: Movie, bookmarkHandler: (() -> Void)?) {
        let movieDetailConfigurator = MovieDetailViewConfigurator(movie: movie, bookmarkHandler: bookmarkHandler)
        self.viewController?.present(UINavigationController(rootViewController: movieDetailConfigurator.configViewController()), animated: true)
        
    }
}
