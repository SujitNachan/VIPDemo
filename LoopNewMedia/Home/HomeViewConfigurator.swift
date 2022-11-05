//
//  HomeViewConfigurator.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import UIKit

protocol Configurator {
    func configViewController() -> UIViewController
}

class HomeConfigurator: Configurator {
    func configViewController() -> UIViewController {
        let viewController = HomeViewController()
        let homeViewPresenter = HomeViewPresenter()
        let homeViewRouter = HomeViewRouter()
        let homeService = HomeService()
        let interactor = HomeViewInteractor(presenter: homeViewPresenter, router: homeViewRouter, service: homeService)
        homeViewPresenter.viewController = viewController
        viewController.interactor = interactor
        homeViewRouter.viewController = viewController
        return viewController
    }
}

