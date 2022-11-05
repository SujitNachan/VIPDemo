//
//  MovieDetailInteractor.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import Foundation

struct MovieDetailViewConfiguration {
    
}

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
            self.presenter.updateMovieData(MovieViewModel(id: movie.id ?? Int.min, posterUrl: movie.posterUrl, rating: movie.rating, releaseDateWithDuration: releaseDateWithDuration, movieTitle: movie.title, releaseYear: movieReleaseYear, genres: movie.genres ?? []))
        }
    }
    
    func bookmarkMovie(_ movieViewModel: MovieViewModel) {
        presenter.updateBookmarkButton(movieViewModel)
    }
    
    var releaseDateWithDuration: String? {
        var releaseDateDuration = ""
        if let releaseDate = movie?.releaseDate?.getDate?.getDDDotMMDotYYYY {
            releaseDateDuration += releaseDate
        }
        if let runtime = movie?.runtime {
            releaseDateDuration += " - " + Double(runtime*60).secondsToHoursMinutesSeconds
        }
        return releaseDateDuration
    }
    
    var movieReleaseYear: String? {
        return movie?.releaseDate?.getDate?.getYYYY
    }
}
