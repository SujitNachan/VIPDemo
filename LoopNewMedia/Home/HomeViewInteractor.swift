//
//  HomeViewInteractor.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import Foundation
class HomeViewInteractor {
    private let presenter: HomeViewPresenterInterface
    private let router: HomeViewRouterInterface
    private let service: ServiceProtocol
    private var dataTask: Task?
    private var movies: [Movie]?
    private var staffPicks: [Movie]?
    
    init(presenter: HomeViewPresenterInterface, router: HomeViewRouterInterface, service: ServiceProtocol) {
        self.presenter = presenter
        self.router = router
        self.service = service
    }
}

extension HomeViewInteractor: HomeViewInteractorInterface {
    func bookmarkStaffPicks(at index: Int) {
        if let id = staffPicks?[index].id {
            UserDefaultDataManager.shared.retriveBookMarks().contains(id) ? UserDefaultDataManager.shared.removeBookmark(id: id) : UserDefaultDataManager.shared.addBookmark(id: id)
        }
        presenter.bookmarkStaffPicks(at: index)
    }
    
    func movieDidSelect(yourFavoriteMovieViewModel: TableViewCellWithCollectionViewViewModel) {
        if let movie = movies?.filter({$0.id == yourFavoriteMovieViewModel.id}).first {
            self.router.navigateToMovieDetailScreen(movie: movie)
        }
    }
    
    func staffPicksDidSelect(staffPicksViewModel: StaffPicksViewModel) {
        if let movie = staffPicks?.filter({$0.id == staffPicksViewModel.id}).first {
            self.router.navigateToMovieDetailScreen(movie: movie)
        }
    }
    
    func fetchMovies() {
        presenter.showActivityIndicator()
        dataTask = service.fetchData(urlString: "https://apps.agentur-loop.com/challenge/movies.json", completion: { [weak self] result in
            guard let self = self else { return }
            self.presenter.hideActivityIndicator()
            switch result {
            case .success(let response):
                self.movies = response.movies
                self.presenter.update(movies: Array(self.movies?.compactMap({TableViewCellWithCollectionViewViewModel(id: $0.id, imageURL: $0.posterUrl, primaryText: nil, secondaryText: nil)}).prefix(upTo: 3) ?? []))
            case .failure(let error):
                self.presenter.showAlertView(message: error.localizedDescription)
            }
        })
    }
    
    func cancelDataTask() {
        dataTask?.cancel()
    }
    
    func fetchStaffPicks() {
        dataTask = service.fetchData(urlString: "https://apps.agentur-loop.com/challenge/staff_picks.json", completion: { [weak self] result in
            guard let self = self else { return }
//            self.presenter.hideActivityIndicator()
            switch result {
            case .success(let response):
                self.staffPicks = response.movies
                self.presenter.update(staffPicks: self.staffPicks?.compactMap({ StaffPicksViewModel.init(id: $0.id, posterImageURL: $0.posterUrl, movieTitle: $0.title, movieReleaseYear: self.getFormattedReleaseDate(movieReleaseYear: $0.releaseDate ?? ""), ratings: $0.rating)}) ?? [])
            case .failure(let error):
                self.presenter.showAlertView(message: error.localizedDescription)
            }
        })
    }
    
    func getFormattedReleaseDate(movieReleaseYear: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        if let date = dateFormatter.date(from: movieReleaseYear) {
            dateFormatter.dateFormat = "YYYY"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
