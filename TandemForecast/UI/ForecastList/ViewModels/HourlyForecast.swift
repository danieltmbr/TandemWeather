//
//  HourlyForeCastViewModel.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

private enum CsvIndex: Int {
    case date = 0, temp, min, max, description, icon
}

struct HourlyForcast: WeatherForecast {

    // MARK: - Properties

    let date: Date

    let temp: Int

    let min: Int

    let max: Int

    let description: String

    let iconId: String?

    // MARK: - Init methods

    init(weather: WeatherForecast) {
        date = weather.date
        temp = weather.temp
        min = weather.min
        max = weather.max
        description = weather.description
        iconId = weather.iconId
    }

    init?(array: [String]) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard array.count >= 5,
            let date = formatter.date(from: array[CsvIndex.date.rawValue]),
            let temp = Double(array[CsvIndex.temp.rawValue]),
            let min = Double(array[CsvIndex.min.rawValue]),
            let max = Double(array[CsvIndex.max.rawValue])
            else { return nil }

        self.date = date
        self.temp = Int(temp.rounded())
        self.min = Int(min.rounded())
        self.max = Int(max.rounded())
        self.description = array[CsvIndex.description.rawValue]
        self.iconId = array.count > 5
            ? array[CsvIndex.icon.rawValue]
            : nil
    }
}

// MARK: - HourlyForcastModel

extension HourlyForcast: HourlyForcastViewModel {

    var hour: String {
        return date.localizedHour
    }

    var temperature: String {
        return "\(temp)°C"
    }

    var minTemp: String {
        return "\(min)°C"
    }

    var maxTemp: String {
        return "\(max)°C"
    }
}
