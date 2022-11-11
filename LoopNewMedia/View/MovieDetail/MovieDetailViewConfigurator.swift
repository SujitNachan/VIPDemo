//
//  MovieDetailConfigurator.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import UIKit

struct MovieDetailViewConfigurator: Configurator {
    private let movie: Movie
    private let bookmarkHandler: (() -> Void)?
    
    init(movie: Movie, bookmarkHandler: (() -> Void)?) {
        self.movie = movie
        self.bookmarkHandler = bookmarkHandler
    }
    
    func configViewController() -> UIViewController {
        let movieDetailViewPresenter = MovieDetailViewPresenter()
        let movieDetailViewRouter = MovieDetailViewRouter()
        let interactor = MovieDetailViewInteractor(presenter: movieDetailViewPresenter, router: movieDetailViewRouter, movieDetailViewConfiguration: MovieDetailConfigurator(bookmarkHandler: bookmarkHandler, movie: movie))
        let viewController = MovieDetailViewController(interactor: interactor)
        movieDetailViewPresenter.viewController = viewController
        movieDetailViewRouter.viewController = viewController
        return viewController
    }
}
