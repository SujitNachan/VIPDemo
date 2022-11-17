//
//  SearchMovieViewConfigurator.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import Foundation
import UIKit

struct SearchMovieViewConfigurator: Configurator {
    private let movies: [Movie]?
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func configViewController() -> UIViewController {
        let searchMovieViewPresenter = SearchMovieViewPresenter()
        let searchMovieViewRouter = SearchMovieViewRouter()
        let interactor = SearchMovieViewInteractor(presenter: searchMovieViewPresenter, router: searchMovieViewRouter, configuration: SearchMovieConfigurator(movies: self.movies))
        let viewController = SearchMovieViewController(interactor: interactor)
        searchMovieViewPresenter.viewController = viewController
        searchMovieViewRouter.viewController = viewController
        return viewController
    }
}
