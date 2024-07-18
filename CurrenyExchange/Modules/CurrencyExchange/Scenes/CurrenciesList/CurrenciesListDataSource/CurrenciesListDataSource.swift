//
//  CurrenciesListDataSource.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

enum CurrenciesListLayoutKind: Hashable {
    case currencySection
}

final class CurrenciesListDataSource: CollectionViewDataSource {

    // MARK: Init
    override init(
        collectionView: UICollectionView,
        actionDelegate: ActionableListView? = nil
    ) {
        super.init(collectionView: collectionView, actionDelegate: actionDelegate)
    }

    // MARK: Internal
    typealias Snapshot = NSDiffableDataSourceSnapshot<CurrenciesListLayoutKind, Currency>
    typealias DataSource = UICollectionViewDiffableDataSource<CurrenciesListLayoutKind, Currency>

    lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            self?.cell(collectionView: collectionView, indexPath: indexPath, currency: itemIdentifier)
        }
        return dataSource
    }()

    var currencies: [Currency] = [] {
        didSet {
            applySnapshot()
        }
    }

    func getItem(at indexPath: IndexPath) -> Currency? {
        dataSource.itemIdentifier(for: indexPath)
    }

    // MARK: Private

    private func cell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        currency: Currency
    ) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrenciesListCollectionViewCell.reuseIdentifier,
            for: indexPath
        )
        bind(for: cell, with: currency)
        return cell
    }

    private func applySnapshot(animatingDifferences: Bool = false) {
        var snapshot = Snapshot()
        snapshot.appendSections([.currencySection])
        snapshot.appendItems(currencies, toSection: .currencySection)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func bind(for cell: UICollectionViewCell, with item: Currency) {
        if let cell = cell as? CurrenciesListCollectionViewCell {
            cell.configure(with: item)
        }
    }
}
