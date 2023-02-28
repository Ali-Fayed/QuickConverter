//
//  CurrencyDetailsRemoteServices.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import RxSwift
class CurrencyDetailsRemoteServices: CurrencyDetailsRemoteInterface {
    // MARK: - Properties
    typealias hisotricalRetunType = Observable<HistoricalConvertsEntity>
    typealias famousReturnType = Observable<FamousCurrenciesEntity>
    // MARK: - Remote Services Methods
    /// Explain for this two methods : ->
    ///   - router: Request router contain the url, headers, path that combine together to build a request
    ///   - model: the return model beacause it's generic type
    ///   - response: Call the network layer singelton
    /// - Returns: Observable off the expected  decodable entity
    func fetchHistoricalConverts(startDate: String, endDate: String, base: String, symbols: String) -> hisotricalRetunType {
        let router = RequestRouter.timeSeriesCurrencyRates(startDate: startDate, endDate: endDate, base: base, symbols: symbols)
        let model = HistoricalConvertsEntity.self
        let response = NetworkingManger.shared.performRequest(router: router, model: model)
        return response
    }
    func fetchFamousConvertes(symbols: String, base: String) -> famousReturnType {
        let router = RequestRouter.latestCurrencyRates(symbol: symbols, base: base)
        let model = FamousCurrenciesEntity.self
        let response = NetworkingManger.shared.performRequest(router: router, model: model)
        return response
    }
}
