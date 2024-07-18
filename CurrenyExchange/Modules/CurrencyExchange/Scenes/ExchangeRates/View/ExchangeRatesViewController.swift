//
//  ExchangeRatesViewController.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

protocol ExchangeRatesView: AnyObject {
    func setExchangeRatesData(exchangeRates: [Rate])
    func setBaseCurrency(currency: String)
    func newCurrencySelected(currency: String)
}

final class ExchangeRatesViewController: UIViewController, ExchangeRatesView {

    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.placeholder = Constants.amountTextFieldPlaceholder
        textField.addDoneButtonToKeyboard(target: self, action: #selector(doneButtonTapped))
        textField.borderColor = .lightGray
        textField.borderWidth = Constants.textfieldBorderWidht
        textField.cornerRadius = Constants.textfieldCornerRadius
        textField.textAlignment = .center
        return textField
    }()

    private lazy var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = Constants.currencyTextFieldPlaceholder
        textField.borderColor = .lightGray
        textField.borderWidth = Constants.textfieldBorderWidht
        textField.cornerRadius = Constants.textfieldCornerRadius
        textField.textAlignment = .center
        textField.backgroundColor = .blue
        textField.textColor = .white
        return textField
    }()

    // MARK: -  Init
    init(presenter: ExchangeRatesPresentation) {
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
    let presenter: ExchangeRatesPresentation
    
    func setExchangeRatesData(exchangeRates: [Rate]) {
        collectionViewDataSource.exchangeRates = exchangeRates
    }

    func setBaseCurrency(currency: String) {
        currencyTextField.text = currency
    }

    func newCurrencySelected(currency: String) {
        setBaseCurrency(currency: currency)
        presenter.doneTappedWith(currency: currency, amount: amountTextField.text ?? Constants.amountTextFieldPlaceholder)
    }

    // MARK: - Private
    private lazy var collectionViewDataSource = ExchangeRatesDataSource(
        collectionView: collectionView
    )

    private func registerCells() {
        collectionView.register(
            ExchangeRatesCollectionViewCell.self,
            forCellWithReuseIdentifier: ExchangeRatesCollectionViewCell.reuseIdentifier
        )
    }

    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout.gridLayout
        collectionView.collectionViewLayout = layout

        collectionView.dataSource = collectionViewDataSource.dataSource
        collectionView.delegate = collectionViewDataSource
    }

    @objc
    private func doneButtonTapped() {
        amountTextField.resignFirstResponder()
        presenter.doneTappedWith(currency: currencyTextField.text, amount: amountTextField.text ?? Constants.amountTextFieldPlaceholder)
    }

}

// MARK: - Setup
private extension ExchangeRatesViewController {

    func setupUI() {
        title = Constants.title
        view.backgroundColor = .white
        stackView.addArrangedSubviews([amountTextField, currencyTextField])
        containerView.addSubview(stackView)
        view.addSubview(containerView)
        view.addSubview(collectionView)
        configureCollectionView()
    }

    func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            amountTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            amountTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            amountTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            currencyTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            currencyTextField.widthAnchor.constraint(equalToConstant: Constants.currencyFieldWidth)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.horizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.horizontalPadding),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.verticalPadding)
        ])

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    enum Constants {
        static let title: String = "Currency Converter"
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 8
        static let height: CGFloat = 100
        static let textFieldHeight: CGFloat = 52
        static let currencyFieldWidth: CGFloat = 100
        static let amountTextFieldPlaceholder = "1.00"
        static let currencyTextFieldPlaceholder = "USD"
        static let textfieldBorderWidht: CGFloat = 0.5
        static let textfieldCornerRadius: CGFloat = 4
        static let stackViewSpacing: CGFloat = 8
    }
}

// MARK: - UITextFieldDelegate
extension ExchangeRatesViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == currencyTextField {
            presenter.selectCurrencyTapped()
            return false
        }
        return true
    }
}
