//
//  CurrencyConvertorRemote.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
class CurrencyConvertorRemote: CurrencyConvertorRemoteProtocol {
    func fetchCurrencySymbols() -> Observable<CurrencySympolsEntity> {
        let response = NetworkingManger.shared.performRequest(router: RequestRouter.symbols, model: CurrencySympolsEntity.self)
        return response
    }
    func fetchLatestCurrencyConverts(from: String, to: String) -> Observable<CurrencyRatesEntity> {
        let response = NetworkingManger.shared.performRequest(router: RequestRouter.latest(from: from, to: to), model: CurrencyRatesEntity.self)
        return response
    }
}
