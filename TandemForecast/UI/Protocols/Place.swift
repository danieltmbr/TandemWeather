//
//  Place.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 28..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

protocol Place {
    var name: String { get }
}

extension String: Place {
    var name: String { return self }
}
