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
    func fetchHistoricalCurrencyConverts(date: String, to: String, from: String) -> Observable<CurrencyRatesEntity> {
        let response = NetworkingManger.shared.performRequest(router: RequestRouter.date(date: date, to: to, from: from), model: CurrencyRatesEntity.self)
        return response
    }
    func fetchFamousConvertedCurrency(fromSymbol: String, toSymbol: String, value: String) -> Observable<CurrencyRatesEntity> {
        let response = NetworkingManger.shared.performRequest(router: RequestRouter.latest(to: toSymbol, from: fromSymbol, base: value), model: CurrencyRatesEntity.self)
        return response
    }
}
