//
//  DailyForecastViewModel.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

final class DailyForecast {

    let date: Date

    let dataSource: UICollectionViewDataSource

    var contentOffset: CGPoint?

    init(date: Date, dataSource: UICollectionViewDataSource) {
        self.date = date
        self.dataSource = dataSource
    }
}

extension DailyForecast: DailyForecastViewModel {

    var day: String {
        return date.localizedDay
    }
}
