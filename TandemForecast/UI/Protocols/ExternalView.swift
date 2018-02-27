//
//  ExternalProtocol.swift
//  TandemForecast
//
//  Created by Daniel Tombor on 2018. 02. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import UIKit

// MARK: - Base External Protocol

protocol ExternalView: class {
    /** Name of the .nib file where the external view is stored */
    static var nibName: String { get }
}

extension ExternalView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }
}

// MARK: - External Reusable Protocol
// TableView & CollectionView cells, headers and footers

protocol ExternalReusableView: ExternalView {
    /** Reuse identifier of the reusable view/cell */
    static var identifier: String { get }
}

extension ExternalReusableView {

    static var identifier: String {
        return String(describing: self)
    }
}

// MARK: - External Reusable Cell
// e.g. UITableViewCell or UICollectionViewCell

protocol ExternalCell: ExternalReusableView { }

// MARK: - External ReusableView Protocol
// e.g.: UICollectionView's header or footer view

protocol ExternalSupplementaryView: ExternalCell {
    /** Kind of reusable view e.g.: header */
    static var kind: String { get }
}

// MARK: - External Reusable default implementations

extension UICollectionView {

    func registerCell(_ externalCell: ExternalCell.Type) {
        register(UINib(nibName: externalCell.nibName, bundle: nil),
                 forCellWithReuseIdentifier: externalCell.identifier)
    }

    func registerView(_ reusableView: ExternalSupplementaryView.Type) {
        register(UINib(nibName: reusableView.nibName, bundle: nil),
                 forSupplementaryViewOfKind: reusableView.kind,
                 withReuseIdentifier: reusableView.nibName)
    }

    func dequeueExternalCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? where T: ExternalCell {
        return dequeueReusableCell(withReuseIdentifier: T.identifier,
                                   for: indexPath) as? T
    }

    func dequeueExternalView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T? where T: ExternalSupplementaryView {
        return dequeueReusableSupplementaryView(ofKind: T.kind,
                                                withReuseIdentifier: T.identifier,
                                                for: indexPath) as? T
    }
}

extension UITableView {

    func register(externalCell: ExternalCell.Type) {
        register(UINib(nibName: externalCell.nibName, bundle: nil),
                 forCellReuseIdentifier: externalCell.identifier)
    }

    func dequeueExternalCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? where T: ExternalCell {
        return dequeueReusableCell(withIdentifier: T.identifier,
                                   for: indexPath) as? T
    }

}

fileprivate extension UIViewController {

    func dequeueError<T: UIView>() -> T {
        assertionFailure("Setup cell of type: \(type(of: T.self))")
        return T()
    }
}
