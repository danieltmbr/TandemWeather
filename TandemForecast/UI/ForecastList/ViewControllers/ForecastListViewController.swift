//
//  ForecastListViewController.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

protocol ForecastListModel: class {

    var cityName: String { get }

    var cityLocation: String? { get }

    var presenter: ForecastPresenter? { get set }

    func getForecasts()
}

final class ForecastListViewController: UIViewController {

    // MARK: - Properties

    private var forecasts: [DailyForecastModel] = []

    private let model: ForecastListModel

    // MARK: - IBOutlets

    @IBOutlet weak private var tableView: UITableView!

    // MARK: - Initialization methods

    required init(model: ForecastListModel) {
        self.model = model
        super.init(nibName: "ForecastListViewController", bundle: nil)
        model.presenter = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(externalCell: DailyForecastCell.self)
        tableView.insetsContentViewsToSafeArea = false
        model.getForecasts()
    }
}

// MARK: -

extension ForecastListViewController: ForecastPresenter {

    func update(forecasts: [DailyForecastModel]) {
        self.forecasts = forecasts
        tableView.reloadData()
    }

    func displayError(_ error: Error) {
        // TODO:
    }
}

// MARK: -

extension ForecastListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DailyForecastCell = tableView.dequeueExternalCell(for: indexPath)
            else { fatalError("Setup your cell correctly") }
        cell.setupCell(with: forecasts[indexPath.item])
        return cell
    }
}
