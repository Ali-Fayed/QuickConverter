//
//  CurrencyDetailsRemote.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxSwift
import RxCocoa
class CurrencyDetailsRemote: CurrencyDetailsRemoteProtocol {
    func fetchHistoricalCurrencyConverts(date: String, symbols: String, base: String) -> Observable<HistoricalConvertsEntity> {
        let response = NetworkingManger.shared.performRequest(router: RequestRouter.date(date: date, symbols: symbols, base: base), model: HistoricalConvertsEntity.self)
        return response
    }
    func fetchFamousConvertedCurrency(symbols: String, base: String) -> Observable<FamousCurrencyRatesEntity> {
        let response = NetworkingManger.shared.performRequest(router: RequestRouter.latest(symbol: symbols, base: base), model: FamousCurrencyRatesEntity.self)
        return response
    }
}
