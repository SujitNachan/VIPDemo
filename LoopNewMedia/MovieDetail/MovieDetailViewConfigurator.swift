//
//  MovieDetailConfigurator.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import UIKit

class MovieDetailViewConfigurator: Configurator {
    private let movie: Movie
    var dimissHandler: (() -> Void)?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func configViewController() -> UIViewController {
        let movieDetailViewPresenter = MovieDetailViewPresenter()
        let movieDetailViewRouter = MovieDetailViewRouter()
        let interactor = MovieDetailViewInteractor(presenter: movieDetailViewPresenter, router: movieDetailViewRouter, movie: movie)
        let viewController = MovieDetailViewController(interactor: interactor)
        movieDetailViewPresenter.viewController = viewController
        movieDetailViewRouter.viewController = viewController
        return viewController
    }
}
