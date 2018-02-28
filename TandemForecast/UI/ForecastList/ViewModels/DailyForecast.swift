//
//  DailyForecastViewModel.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

// MARK: -

final class DailyForecast {

    // MARK: Properties

    let date: Date

    let dataSource: UICollectionViewDataSource

    var contentOffset: CGPoint?

    // MARK: - Initialisation

    init(date: Date, dataSource: UICollectionViewDataSource) {
        self.date = date
        self.dataSource = dataSource
    }
}

// MARK: -

extension DailyForecast: DailyForecastViewModel {

    var day: String {
        return date.localizedDay
    }
}
