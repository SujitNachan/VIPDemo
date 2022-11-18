//
//  SearchMovieViewRouter.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import UIKit

class SearchMovieViewRouter {
    weak var viewController: UIViewController?
}

extension SearchMovieViewRouter: SearchMovieViewRouterInterface {
    func navigateToDetailsScreen(_ movie: Movie, bookmarkHandler: (() -> Void)?) {
        let movieDetailConfigurator = MovieDetailViewConfigurator(movie: movie, bookmarkHandler: bookmarkHandler)
        self.viewController?.present(UINavigationController(rootViewController: movieDetailConfigurator.configViewController()), animated: true)
    }
}
