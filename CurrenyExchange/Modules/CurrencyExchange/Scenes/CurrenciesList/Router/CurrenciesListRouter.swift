//
//  CurrenciesListRouter.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

protocol CurrenciesListRouting {
    func presentCurrenciesList(
        from sourceViewController: UIViewController?,
        selectionHandler: @escaping (Currency?) -> Void
    )
    func dismiss()
}

final class CurrenciesListRouter: CurrenciesListRouting {

    // MARK: - Private
    private weak var viewController: UIViewController?
    private let builder: CurrenciesListBuilding

    // MARK: - Init
    init(builder: CurrenciesListBuilding = CurrenciesListBuilder()) {
        self.builder = builder
    }

    // MARK: - Internal
    func presentCurrenciesList(
        from sourceViewController: UIViewController?,
        selectionHandler: @escaping (Currency?) -> Void
    ) {
        viewController = builder.buildCurrenciesList(
            with: self,
            selectionHandler: selectionHandler
        )

        guard let view = viewController else { return }
        sourceViewController?.present(view, animated: true)
    }

    func dismiss() {
        viewController?.dismiss(animated: true)
    }

}
