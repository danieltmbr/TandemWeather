//
//  DailyForecastCell.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

// MARK: -

protocol DailyForecastModel {

    var day: String { get }

    var contentOffset: CGPoint? { get set }

    var dataSource: UICollectionViewDataSource { get }

    func indexPathForCurrentTime() -> IndexPath
}

// MARK: -

final class DailyForecastCell: UITableViewCell, ExternalCell {

    // MARK: Properties

    private var model: DailyForecastModel?

    // MARK: - IBOutlets

    @IBOutlet weak private var dayLabel: UILabel!

    @IBOutlet weak private var collectionView: UICollectionView!

    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerCell(HourlyForecastCell.self)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        model?.contentOffset = collectionView.contentOffset
    }

    // MARK: - Public methods

    func setupCell(with model: DailyForecastModel?) {
        self.model = model
        guard let model = model
            else { return clear() }

        dayLabel.text = model.day
        collectionView.dataSource = model.dataSource
        collectionView.reloadData()

        // TODO: Scroll to previous contentoffset
        collectionView.scrollToItem(
            at: model.indexPathForCurrentTime(),
            at: .left,
            animated: false)
    }

    // MARK: - Private methods

    private func clear() {
        collectionView.dataSource = nil
        collectionView.reloadData()
    }
}
