//
//  CsvDecoder.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 27..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

final class WeatherCsvDecoder {

    private func parseCsv(named: String) throws -> [HourlyForcast] {
        let csvContent = try openCsv(named: named)
        let entryStrings = csvContent.components(separatedBy: .newlines)
        return entryStrings
            .map { $0.components(separatedBy: ",") }
            .flatMap { HourlyForcast(array: $0) }
    }

    private func openCsv(named: String) throws -> String {
        guard let path = Bundle.main.path(forResource: named, ofType: "csv")
            else { throw CsvError.noSuchFile }
        let contents = try String(contentsOfFile: path)
        return contents
    }
}

extension WeatherCsvDecoder: ForecastService {

    func fetchForecasts(for place: Place, callback: @escaping ([WeatherForecast]?, Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            do {
                let weather = try strongSelf.parseCsv(named: place.name)
                callback(weather, nil)
            } catch let error {
                callback(nil, error)
            }
        }
    }
}
