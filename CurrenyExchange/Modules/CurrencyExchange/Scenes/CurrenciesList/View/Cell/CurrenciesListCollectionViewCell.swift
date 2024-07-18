//
//  CurrenciesListCollectionViewCell.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

final class CurrenciesListCollectionViewCell: UICollectionViewCell, ReusableView {

    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Congigure cell
    func configure(with currency: Currency) {
        titleLabel.text = currency.code + " - " + currency.name

    }
}

// MARK: - Setup
private extension CurrenciesListCollectionViewCell {

    enum Constants {
        static let padding: CGFloat = 16.0
    }

    func setupUI() {
        contentView.addSubview(titleLabel)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding)
        ])
    }
}
