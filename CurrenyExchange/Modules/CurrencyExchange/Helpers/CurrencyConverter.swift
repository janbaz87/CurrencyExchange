//
//  CurrencyConverter.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 08/11/2023.
//

import Foundation

protocol CurrencyConvertable {
    func convertAmount(amount: Double,
        with baseCurrency: String,
        to selectedCurrency: String,
        from exchangeRates: [String: Double]
    ) -> [String: Double]
}

final class CurrencyConverter: CurrencyConvertable {

    // MARK: - Internal
    func convertAmount(amount: Double,
        with baseCurrency: String,
        to selectedCurrency: String,
        from exchangeRates: [String: Double]
    ) -> [String: Double] {
        let selectedCurrencyRate = exchangeRates[selectedCurrency] ?? 1.0 // Default to 1.0 if the selected currency is not in the rates

        var convertedRates: [String: Double] = [:]
        for (currency, rate) in exchangeRates {
            let conversionFactor = rate / selectedCurrencyRate
            convertedRates[currency] = conversionFactor * amount
        }

        return convertedRates
    }

}
