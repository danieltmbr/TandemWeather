//
//  AppRouter.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 26..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit


final class AppRouter {

    private let window: UIWindow

    private let tabbarController: UITabBarController

    init(window: UIWindow) {
        self.window = window
        tabbarController = UITabBarController()

    }

    func start() {

        let onlineViewModel = ForecastListViewModel(service: ForecastFetcher(), cityName: "London")
        let onlineListViewController = ForecastListViewController(model: onlineViewModel)
        onlineListViewController.tabBarItem = UITabBarItem(title: "Open weather", image: #imageLiteral(resourceName: "apiTabBarIcon"), selectedImage: nil)
        onlineListViewController.title = "London"

        let onlineViewModel2 = ForecastListViewModel(service: ForecastFetcher(), cityName: "London")
        let csvListViewController = ForecastListViewController(model: onlineViewModel2)
        csvListViewController.tabBarItem = UITabBarItem(title: "Offline", image: #imageLiteral(resourceName: "csvTabBarIcon"), selectedImage: nil)

        tabbarController.viewControllers = [
            UINavigationController(rootViewController: onlineListViewController),
            UINavigationController(rootViewController: csvListViewController)
        ]

        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
    }
}
