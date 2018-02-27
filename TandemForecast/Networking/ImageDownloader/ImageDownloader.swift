//
//  ImageDownloader.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 27..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

protocol CancelableRequest {
    func cancel()
}

protocol ImageFetcher {

    typealias ImageDownloadCallback = (UIImage?, Error?) -> Void

    func fetchIcon(id: String, callback: @escaping ImageDownloadCallback) -> CancelableRequest?
}

final class ImageDownloader: ImageFetcher {

    // MARK: - Properties

    private let session: URLSession

    private let iconUrl: String = "https://openweathermap.org/img/w/%@.png"

    static let shared = ImageDownloader()

    // MARK: - Initialisation

    private init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession(configuration: config)
    }

    // MARK: - Public methods

    func fetchIcon(id: String, callback: @escaping ImageDownloadCallback) -> CancelableRequest? {

        guard let url = URL(string: String(format: iconUrl, id)) else {
            callback(nil, ServiceError.invalidUrl)
            return nil
        }

        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data,
                let image = UIImage(data: data)
                else { return callback(nil, error) }
            callback(image, nil)
        }
        dataTask.resume()
        return dataTask
    }
}

extension URLSessionDataTask: CancelableRequest {}
