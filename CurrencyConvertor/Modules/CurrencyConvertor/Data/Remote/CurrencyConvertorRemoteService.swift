//
//  CurrencyConvertorRemoteService.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import RxSwift
class CurrencyConvertorRemoteService: CurrencyConvertorRemoteInterface {
    // MARK: - Properties
    typealias symbolsReturnType = Observable<CurrencySymbolsEntity>
    typealias currencyConvertReturnType = Observable<CurrencyConvertEntity>
    // MARK: - Remote Services Methods
    /// Explain for this two methods : ->
    ///   - router: Request router contain the url, headers, path that combine together to build a request
    ///   - model: the return model beacause it's generic type
    ///   - response: Call the network layer singelton
    /// - Returns: Observable off the expected  decodable entity
    func fetchCurrencySymbols() -> symbolsReturnType {
        let router = RequestRouter.currencySymbols
        let model = CurrencySymbolsEntity.self
        let response = NetworkingManger.shared.performRequest(router: router, model: model)
        return response
    }
    func fetchCurrencyConverts(from: String, to: String, ammout: String) -> currencyConvertReturnType {
        let router = RequestRouter.convertCurrency(to: to, from: from, amount: ammout)
        let model = CurrencyConvertEntity.self
        let response = NetworkingManger.shared.performRequest(router: router, model: model)
        return response
    }
}
