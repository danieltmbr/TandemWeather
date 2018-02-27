//
//  CsvError.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 27..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

enum CsvError: Error {
    case noSuchFile
    case fileReadError
}
