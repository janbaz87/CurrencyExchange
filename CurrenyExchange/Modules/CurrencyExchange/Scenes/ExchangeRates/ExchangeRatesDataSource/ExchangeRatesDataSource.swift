//
//  ExchangeRatesDataSource.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

enum ExchangeRatesLayoutKind: Hashable {
    case ratesSection
}

final class ExchangeRatesDataSource: CollectionViewDataSource {

    // MARK: Init
    override init(
        collectionView: UICollectionView,
        actionDelegate: ActionableListView? = nil
    ) {
        super.init(collectionView: collectionView, actionDelegate: actionDelegate)
    }

    // MARK: Internal
    typealias Snapshot = NSDiffableDataSourceSnapshot<ExchangeRatesLayoutKind, Rate>
    typealias DataSource = UICollectionViewDiffableDataSource<ExchangeRatesLayoutKind, Rate>

    lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            self?.cell(collectionView: collectionView, indexPath: indexPath, rate: itemIdentifier)
        }
        return dataSource
    }()

    var exchangeRates: [Rate] = [] {
        didSet {
            applySnapshot()
        }
    }

    func getItem(at indexPath: IndexPath) -> Rate? {
        dataSource.itemIdentifier(for: indexPath)
    }

    // MARK: Private
    private func cell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        rate: Rate
    ) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ExchangeRatesCollectionViewCell.reuseIdentifier,
            for: indexPath
        )
        bind(for: cell, with: rate)
        return cell
    }

    private func applySnapshot(animatingDifferences: Bool = false) {
        var snapshot = Snapshot()
        snapshot.appendSections([.ratesSection])
        snapshot.appendItems(exchangeRates, toSection: .ratesSection)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func bind(for cell: UICollectionViewCell, with item: Rate) {
        if let cell = cell as? ExchangeRatesCollectionViewCell {
            cell.configure(with: item)
        }
    }
}
