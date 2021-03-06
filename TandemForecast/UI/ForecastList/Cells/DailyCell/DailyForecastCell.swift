//
//  DailyForecastCell.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

// MARK: -

protocol DailyForecastViewModel {

    var day: String { get }

    var contentOffset: CGPoint? { get set }

    var dataSource: UICollectionViewDataSource { get }
}

// MARK: -

final class DailyForecastCell: UITableViewCell, ExternalCell {

    // MARK: Properties

    private var model: DailyForecastViewModel?

    // MARK: - IBOutlets

    @IBOutlet weak private var dayLabel: UILabel!

    @IBOutlet weak private(set) var collectionView: UICollectionView!

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

    func setupCell(with model: DailyForecastViewModel?) {
        self.model = model
        guard let model = model
            else { return clear() }

        dayLabel.text = model.day
        collectionView.dataSource = model.dataSource
        collectionView.reloadData()

        if let contentOffset = model.contentOffset {
            collectionView.setContentOffset(contentOffset, animated: false)
        }
    }

    // MARK: - Private methods

    private func clear() {
        collectionView.dataSource = nil
        collectionView.reloadData()
    }
}
