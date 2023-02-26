//
//  CurrencyDetailsRemote.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxSwift
import RxCocoa
class CurrencyDetailsRemoteServices: CurrencyDetailsRemoteProtocol {
    typealias hisotricalRetunType = Observable<HistoricalConvertsEntity>
    typealias famousReturnType = Observable<FamousCurrencyEntity>
    func fetchHistoricalConverts(date: String, symbols: String, base: String) -> hisotricalRetunType {
        let router = RequestRouter.currenciesByDate(date: date, symbols: symbols, base: base)
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
