//
//  SearchMovieViewInteractor.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import Foundation

protocol SearchMovieViewConfiguration {
    var movies: [Movie]? { get set }
}

struct SearchMovieConfigurator: SearchMovieViewConfiguration {
    var movies: [Movie]?
}

class SearchMovieViewInteractor: SearchMovieViewInteractorInterface {
    private let presenter: SearchMovieViewPresenterInterface
    private let router: SearchMovieViewRouterInterface
    private let configuration: SearchMovieViewConfiguration
    
    init(presenter: SearchMovieViewPresenterInterface, router: SearchMovieViewRouterInterface, configuration: SearchMovieViewConfiguration) {
        self.presenter = presenter
        self.router = router
        self.configuration = configuration
    }
    
    func getMovies() {
        presenter.updateMovies(configuration.movies?.compactMap({StaffPicksViewModel(id: $0.id, posterImageURL: $0.posterUrl, movieTitle: $0.title, movieReleaseYear: $0.releaseYear, ratings: $0.rating)}) ?? [])
    }
    
    func bookmarkMovie(at index: Int) {
        
    }
}
