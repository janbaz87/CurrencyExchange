//
//  ExchangeRatesTableViewCell.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

final class ExchangeRatesCollectionViewCell: UICollectionViewCell, ReusableView{

    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var exchageRateLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = 8
        view.borderColor = .gray
        view.borderWidth = 1
        return view
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
    func configure(with exchangeRate: Rate) {
        exchageRateLabel.text = exchangeRate.rate
        titleLabel.text = exchangeRate.code
    }

}

// MARK: - Setup
private extension ExchangeRatesCollectionViewCell {

    private enum Constants {
        static let innerPadding: CGFloat = 8.0
        static let padding: CGFloat = 16.0
        static let size: CGFloat = 120
    }

    func setupUI() {
        stackView.addArrangedSubviews([titleLabel, exchageRateLabel])
        containerView.addSubview(stackView)
        contentView.addSubview(containerView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.innerPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.innerPadding)
        ])

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.innerPadding),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.innerPadding),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.innerPadding),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.innerPadding)
        ])
    }
}

