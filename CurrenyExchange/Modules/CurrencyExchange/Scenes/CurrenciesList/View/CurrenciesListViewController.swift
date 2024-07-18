//
//  CurrenciesListViewController.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

protocol CurrenciesListView: AnyObject {
    func setCurrenciesListData(currencies: [Currency])
}

final class CurrenciesListViewController: UIViewController, CurrenciesListView {

    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: -  Init
    init(presenter: CurrenciesListPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupUI()
        configureConstraints()
        registerCells()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifcyle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    // MARK: - Internal
    let presenter: CurrenciesListPresentation
    
    func setCurrenciesListData(currencies: [Currency]) {
        collectionViewDataSource.currencies = currencies
    }

    func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout.listLayout(backgroundColor: .white)
        collectionView.collectionViewLayout = layout

        collectionView.dataSource = collectionViewDataSource.dataSource
        collectionView.delegate = collectionViewDataSource
    }

    // MARK: - Private
    private lazy var collectionViewDataSource = CurrenciesListDataSource(
        collectionView: collectionView,
        actionDelegate: self
    )

    private func registerCells() {
        collectionView.register(
            CurrenciesListCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrenciesListCollectionViewCell.reuseIdentifier
        )
    }

}

// MARK: - ActionableListView
extension CurrenciesListViewController: ActionableListView {
    func didPerformAction(indexPath: IndexPath) {
        let curency = collectionViewDataSource.getItem(at: indexPath)
        presenter.didSelect(currency: curency)
    }
}

// MARK: - Setup
private extension CurrenciesListViewController {
    func setupUI() {
        configureCollectionView()
        view.addSubview(collectionView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
