//
//  CurrencyDetailsRemoteServices.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxSwift
class CurrencyDetailsRemoteServices: CurrencyDetailsRemoteProtocol {
    typealias hisotricalRetunType = Observable<HistoricalConvertsEntity>
    typealias famousReturnType = Observable<FamousCurrencyEntity>
    func fetchHistoricalConverts(startDate: String, endDate: String, base: String, symbols: String) -> hisotricalRetunType {
        let router = RequestRouter.timeSeriesCurrencyRates(startDate: startDate, endDate: endDate, base: base, symbols: symbols)
        let model = HistoricalConvertsEntity.self
        let response = NetworkingManger.shared.performRequest(router: router, model: model)
        return response
    }
    func fetchFamousConvertes(symbols: String, base: String) -> famousReturnType {
        let router = RequestRouter.latestCurrencyRates(symbol: symbols, base: base)
        let model = FamousCurrencyEntity.self
        let response = NetworkingManger.shared.performRequest(router: router, model: model)
        return response
    }
}
