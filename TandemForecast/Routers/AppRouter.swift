//
//  AppRouter.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 26..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

final class AppRouter {

    // MARK: - Properties

    private let window: UIWindow

    private let tabbarController: UITabBarController

    // MARK: - Initialisation

    init(window: UIWindow) {
        self.window = window
        tabbarController = UITabBarController()
    }

    // MARK: - Public methods

    func start() {
        tabbarController.viewControllers = [
            UINavigationController(rootViewController: onlineForecastScene()),
            UINavigationController(rootViewController: offlineForecastScene())
        ]
        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
    }

    // MARK: - Private methods

    private func onlineForecastScene() -> UIViewController {
        let onlineViewModel = ForecastListViewModel(service: ForecastFetcher(), cityName: "London")
        let onlineListViewController = ForecastListViewController(model: onlineViewModel)
        onlineListViewController.tabBarItem = UITabBarItem(title: "Open weather", image: #imageLiteral(resourceName: "apiTabBarIcon"), selectedImage: nil)
        return onlineListViewController
    }

    private func offlineForecastScene() -> UIViewController {
        let onlineViewModel2 = ForecastListViewModel(service: ForecastFetcher(), cityName: "London")
        let csvListViewController = ForecastListViewController(model: onlineViewModel2)
        csvListViewController.tabBarItem = UITabBarItem(title: "Offline", image: #imageLiteral(resourceName: "csvTabBarIcon"), selectedImage: nil)
        return csvListViewController
    }
}
