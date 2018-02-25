//
//  DailyForecastViewModel.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

final class DailyForecastViewModel {

    let date: Date

    let dataSource: UICollectionViewDataSource

    var contentOffset: CGPoint?

    init(date: Date, dataSource: UICollectionViewDataSource) {
        self.date = date
        self.dataSource = dataSource
    }
}

extension DailyForecastViewModel: DailyForecastModel {

    var day: String {
        return date.localizedDay
    }

    func indexPathForCurrentTime() -> IndexPath {
        return IndexPath(item: 0, section: 0)
    }
}


