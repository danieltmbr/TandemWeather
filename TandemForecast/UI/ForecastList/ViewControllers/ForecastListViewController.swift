//
//  ForecastListViewController.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

protocol ForecastListViewModel: class {

    var location: Place { get set }

    var locations: [Place] { get }

    var presenter: ForecastPresenter? { get set }

    func getForecasts()
}

final class ForecastListViewController: UIViewController {

    // MARK: - Properties

    private var forecasts: [DailyForecastViewModel] = []

    private let model: ForecastListViewModel

    // MARK: - IBOutlets

    @IBOutlet weak private var tableView: UITableView!

    @IBOutlet weak private var loaderView: UIView!

    @IBOutlet weak private var errorContainerView: UIView!

    // MARK: - Initialization methods

    required init(model: ForecastListViewModel) {
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
        title = model.location.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "locationIcon"),
            style: .plain,
            target: self,
            action: #selector(locationItemTapped(_:)))
        tableView.register(externalCell: DailyForecastCell.self)
        tableView.insetsContentViewsToSafeArea = false
        fetchForecast()
    }

    // MARK: - IBActions

    @IBAction private func errorContainerTapped(_ sender: UITapGestureRecognizer) {
        fetchForecast()
    }

    // MARK: - Private methods

    @objc
    private func locationItemTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(
            title: NSLocalizedString("Select location", comment: "Button title which opens a location selector"),
            message: nil,
            preferredStyle: .actionSheet
        )
        for place in model.locations {
            let action = UIAlertAction(title: place.name, style: .default) { _ in
                guard place.name != self.model.location.name else { return }
                self.model.location = place
                self.title = place.name
            }
            alertController.addAction(action)
        }
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender
        }
        present(alertController, animated: true, completion: nil)
    }

    private func fetchForecast() {
        enableLocationChange(false)
        errorContainerView.isHidden = true
        model.getForecasts()
    }

    private func enableLocationChange(_ enable: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = enable
    }
}

// MARK: -

extension ForecastListViewController: ForecastPresenter {

    func update(forecasts: [DailyForecastViewModel]) {
        self.forecasts = forecasts
        tableView.reloadData()
        enableLocationChange(true)
    }

    func displayError(_ error: Error) {
        errorContainerView.isHidden = false
        enableLocationChange(true)
    }

    func displayLoader() {
        loaderView.isHidden = false
    }

    func dismissLoader() {
        loaderView.isHidden = true
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
