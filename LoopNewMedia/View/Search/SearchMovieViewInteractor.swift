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
    private var ratings: [RatingViewModel] = []
    private var selectedRating: Int?
    private var searchText = ""
    
    init(presenter: SearchMovieViewPresenterInterface, router: SearchMovieViewRouterInterface, configuration: SearchMovieViewConfiguration) {
        self.presenter = presenter
        self.router = router
        self.configuration = configuration
    }
    
    func getMovies() {
        presenter.updateMovies(configuration.movies?.compactMap({StaffPicksViewModel(id: $0.id, posterImageURL: $0.posterUrl, movieTitle: $0.title, movieReleaseYear: $0.releaseYear, ratings: $0.rating)}) ?? [])
    }
    
    func getRatings() {
        for i in (1...5).reversed() {
            ratings.append(RatingViewModel(rating: i, isSelected: false))
        }
        presenter.updateRatings(ratings)
    }
    
    func didSelectRating(at index: Int) {
        for i in 0...ratings.count-1 {
            ratings[i].isSelected = index == i ? !ratings[index].isSelected : false
        }
        selectedRating = ratings[index].isSelected ? ratings[index].rating : nil
        presenter.updateRatings(ratings)
        searchMovie()
    }
    
    func bookmarkMovie(at index: Int) {
        if let id = configuration.movies?[index].id {
            UserDefaultDataManager.shared.retriveBookMarks().contains(id) ? UserDefaultDataManager.shared.removeBookmark(id: id) : UserDefaultDataManager.shared.addBookmark(id: id)
        }
        presenter.reloadBookmarkCell(at: index)
    }
    
    func didSelectMovie(_ movie: StaffPicksViewModel) {
        if let movie = configuration.movies?.filter({$0.id == movie.id}).first {
            router.navigateToDetailsScreen(movie) { [unowned self] in
                if let index = configuration.movies?.firstIndex(where: {$0.id == movie.id}) {
                    self.presenter.reloadBookmarkCell(at: index)
                }
            }
        }
    }
    
    func searchMovieWith(title: String?) {
        self.searchText = title ?? ""
        searchMovie()
    }
    
    private func searchMovie() {
        guard let movies = configuration.movies else { return }
        var filteredMovie: [StaffPicksViewModel] = []
        if !searchText.isEmpty {
            filteredMovie = movies.filter({($0.title?.localizedCaseInsensitiveContains(self.searchText)) ?? false}).compactMap({StaffPicksViewModel(id: $0.id, posterImageURL: $0.posterUrl, movieTitle: $0.title, movieReleaseYear: $0.releaseYear, ratings: $0.rating)})
        } else {
            filteredMovie = movies.compactMap({StaffPicksViewModel(id: $0.id, posterImageURL: $0.posterUrl, movieTitle: $0.title, movieReleaseYear: $0.releaseYear, ratings: $0.rating)})
        }
        
        if let rating  = self.selectedRating {
            filteredMovie = filteredMovie.filter({Int($0.ratings ?? 0) == rating})
        }
        self.presenter.updateMovies(filteredMovie)
    }
}
