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
        let viewModel = ForecastList(
            service: OnlineForecastService(),
            locations: ["London", "Brighton", "Manchester", "Liverpool", "Cambridge"]
        )
        let listViewController = ForecastListViewController(model: viewModel)
        listViewController.tabBarItem = UITabBarItem(title: "Online", image: #imageLiteral(resourceName: "apiTabBarIcon"), selectedImage: nil)
        return listViewController
    }

    private func offlineForecastScene() -> UIViewController {
        let viewModel = ForecastList(
            service: WeatherCsvDecoder(),
            locations: ["Caradhras", "Mordor"]
        )
        let listViewController = ForecastListViewController(model: viewModel)
        listViewController.tabBarItem = UITabBarItem(title: "Offline", image: #imageLiteral(resourceName: "csvTabBarIcon"), selectedImage: nil)
        return listViewController
    }
}
