//
//  MovieDetailInteractor.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import Foundation

class MovieDetailViewInteractor: MovieDetailViewInteractorInterface {
    private let presenter: MovieDetailViewPresenterInterface
    private let router: MovieDetailViewRouterInterface
    private var movie: Movie?
    
    init(presenter: MovieDetailViewPresenterInterface, router: MovieDetailViewRouterInterface, movie: Movie) {
        self.presenter = presenter
        self.router = router
        self.movie = movie
    }
    
    func getMovieData() {
        if let movie = movie {
            self.presenter.updateMovieData(movie)
        }
    }
}
