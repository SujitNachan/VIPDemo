//
//  MovieDetailInteractor.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import Foundation

protocol MovieDetailViewConfiguration {
    var movie: Movie? { get set }
}

struct MovieDetailViewData: MovieDetailViewConfiguration {
    var movie: Movie?
}

class MovieDetailViewInteractor: MovieDetailViewInteractorInterface {
    private let presenter: MovieDetailViewPresenterInterface
    private let router: MovieDetailViewRouterInterface
    private let movieDetailViewConfiguration: MovieDetailViewConfiguration
    
    private var releaseDateWithDuration: String? {
        var releaseDateDuration = ""
        if let releaseDate = movieDetailViewConfiguration.movie?.releaseDate?.getDate?.getDDDotMMDotYYYY {
            releaseDateDuration += releaseDate
        }
        if let runtime = movieDetailViewConfiguration.movie?.runtime {
            releaseDateDuration += " - " + Double(runtime*60).secondsToHoursMinutesSeconds
        }
        return releaseDateDuration
    }
    
    private var movieReleaseYear: String? {
        return movieDetailViewConfiguration.movie?.releaseDate?.getDate?.getYYYY
    }
    
    init(presenter: MovieDetailViewPresenterInterface, router: MovieDetailViewRouterInterface, movieDetailViewConfiguration: MovieDetailViewConfiguration) {
        self.presenter = presenter
        self.router = router
        self.movieDetailViewConfiguration = movieDetailViewConfiguration
    }
    
    func getSectionsData() {
        if let movie = movieDetailViewConfiguration.movie {
            self.presenter.updateSectionsData(MovieSectionDetailViewModel(movieViewModel: MovieViewModel(id: movie.id ?? Int.min, posterUrl: movie.posterUrl, rating: movie.rating, releaseDateWithDuration: releaseDateWithDuration, movieTitle: movie.title, releaseYear: movieReleaseYear, genres: movie.genres ?? []), overView: movie.overview, director: TableViewCellWithCollectionViewViewModel(id: nil, imageURL: movie.director?.pictureUrl, primaryText: movie.director?.name, secondaryText: nil), actors: movie.cast?.compactMap({TableViewCellWithCollectionViewViewModel(id: nil, imageURL: $0.pictureUrl, primaryText: $0.name, secondaryText: $0.character)}) ?? []))
        }
    }
    
    func bookmarkMovie(_ movieViewModel: MovieViewModel) {
        presenter.updateBookmarkButton(movieViewModel)
    }
}
