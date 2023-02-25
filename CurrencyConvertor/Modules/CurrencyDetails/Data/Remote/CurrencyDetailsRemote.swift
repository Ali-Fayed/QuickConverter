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
    func fetchFamousConvertedCurrency(symbols: String, base: String) -> Observable<CurrencyRatesEntity> {
        let response = NetworkingManger.shared.performRequest(router: RequestRouter.latest(symbol: symbols, base: base), model: CurrencyRatesEntity.self)
        return response
    }
}
