//
//  CurrencyService.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 02/11/2023.
//
import Networking
protocol CurrrencyServiceProviding {
    func fetchCurrenciesList() async -> Result<CurrencyListResponse?, AppError>
    func fetchCurrencyExchangeRates() async -> Result<CurrencyExchangeRateResponse?, AppError>
}

final class CurrencyService: CurrrencyServiceProviding {

    private let networking: NetworkProviding

    init(networking: NetworkProviding) {
        self.networking = networking
    }

    func fetchCurrenciesList() async -> Result<CurrencyListResponse?, AppError> {
        let path = CurrencyExchangeEndpoint.currenciesList.path
        let parameters = CurrenciesListRequestParameters()
        let request = CurrenciesListRequest(path: path, parameters: parameters)
        
        let result = await networking.request(
            requestable: request,
            responseType: [String : String].self
        )
        
        switch result {
            
        case .success(let currencies):
            print("api success /n \(currencies)")
            return .success(CurrencyListResponse.init(currencies: currencies))
        case .failure(let error):
            handleError(error: error)
            return .failure(.networkingError)
        }
    }

    func fetchCurrencyExchangeRates() async -> Result<CurrencyExchangeRateResponse?, AppError> {
        let path = CurrencyExchangeEndpoint.exchageRates.path
        let parameters = CurrenciesListRequestParameters()
        let request = CurrenciesListRequest(path: path, parameters: parameters)

        let result = await networking.request(
            requestable: request,
            responseType: CurrencyExchangeRateResponse.self
        )

        switch result {
        case .success(let exchangeRates):
            print("api success /n \(exchangeRates)")
            return .success(exchangeRates)
        case .failure(let error):
            handleError(error: error)
            return .failure(.networkingError)
        }
    }

    private func handleError(error: NetworkError) {
        switch error {
        case .noHTTPResponse:
            print("noHTTPResponse")
        case .clientError:
            print("clientError")
        case .serverError:
            print("serverError")
        case .invalidURL:
            print("invalidURL")
        case .serialization:
            print("serialization failure")
        case .unknown:
            print("api failure")
        }
    }
}
