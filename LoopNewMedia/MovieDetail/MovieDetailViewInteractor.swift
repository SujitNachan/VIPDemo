//
//  MovieDetailInteractor.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import Foundation

protocol MovieDetailViewConfiguration {
    var movie: Movie? { get set }
    var bookmarkHandler: (() -> Void)? { get set }
}

struct MovieDetailConfigurator: MovieDetailViewConfiguration {
    var bookmarkHandler: (() -> Void)?
    var movie: Movie?
}

class MovieDetailViewInteractor: MovieDetailViewInteractorInterface {
    private let presenter: MovieDetailViewPresenterInterface
    private let router: MovieDetailViewRouterInterface
    private let configuration: MovieDetailViewConfiguration
    
    private var releaseDateWithDuration: String? {
        var releaseDateDuration = ""
        if let releaseDate = configuration.movie?.releaseDate?.getDate?.getDDDotMMDotYYYY {
            releaseDateDuration += releaseDate
        }
        if let runtime = configuration.movie?.runtime {
            releaseDateDuration += " - " + Double(runtime*60).secondsToHoursMinutesSeconds
        }
        return releaseDateDuration
    }
    
    private var movieReleaseYear: String? {
        return configuration.movie?.releaseDate?.getDate?.getYYYY
    }
    
    init(presenter: MovieDetailViewPresenterInterface, router: MovieDetailViewRouterInterface, movieDetailViewConfiguration: MovieDetailViewConfiguration) {
        self.presenter = presenter
        self.router = router
        self.configuration = movieDetailViewConfiguration
    }
    
    func getSectionsData() {
        if let movie = configuration.movie {
            self.presenter.updateSectionsData(MovieSectionDetailViewModel(movieViewModel: MovieViewModel(id: movie.id ?? Int.min, posterUrl: movie.posterUrl, rating: movie.rating, releaseDateWithDuration: releaseDateWithDuration, movieTitle: movie.title, releaseYear: movieReleaseYear, genres: movie.genres ?? []), overView: movie.overview, director: TableViewCellWithCollectionViewViewModel(id: nil, imageURL: movie.director?.pictureUrl, primaryText: movie.director?.name, secondaryText: nil), actors: movie.cast?.compactMap({TableViewCellWithCollectionViewViewModel(id: nil, imageURL: $0.pictureUrl, primaryText: $0.name, secondaryText: $0.character)}) ?? [], keyFacts: KeyFactsTableViewCellConfigurator(cellData: getKeyFactCellData())))
        }
    }
    
    func bookmarkMovie(_ movieViewModel: MovieViewModel) {
        presenter.updateBookmarkButton(movieViewModel)
        configuration.bookmarkHandler?()
    }
    
    private func getKeyFactCellData() -> [KeyFactViewModel] {
        var array = [KeyFactViewModel]()
        if let movie = configuration.movie {
            let amount = (movie.budget ?? 0).formatted(.currency(code: "USD"))
            array.append(KeyFactViewModel(placeholder: "Budget", value: amount))
            let revenue = (movie.revenue ?? 0).formatted(.currency(code: "USD"))
            array.append(KeyFactViewModel(placeholder: "Revenue", value: revenue))
            array.append(KeyFactViewModel(placeholder: "Original Language", value: movie.language ?? ""))
            let rating = String(format: "%.2f", movie.rating ?? 0.0)
            array.append(KeyFactViewModel(placeholder: "Rating", value: rating))
        }
        return array
    }
}
