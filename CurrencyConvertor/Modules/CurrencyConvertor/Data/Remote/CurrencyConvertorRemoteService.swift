//
//  CurrencyConvertorRemoteService.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
class CurrencyConvertorRemoteService: CurrencyConvertorRemoteProtocol {
    typealias symbolsReturnType = Observable<CurrencySymbolsEntity>
    typealias CurrencyConvertReturnType = Observable<CurrencyConvertEntity>
    func fetchCurrencySymbols() -> symbolsReturnType {
        let router = RequestRouter.symbols
        let model = CurrencySymbolsEntity.self
        let response = NetworkingManger.shared.performRequest(router: router, model: model)
        return response
    }
    func fetchCurrencyConverts(from: String, to: String, ammout: String) -> CurrencyConvertReturnType {
        let router = RequestRouter.convert(to: to, from: from, amount: ammout)
        let model = CurrencyConvertEntity.self
        let response = NetworkingManger.shared.performRequest(router: router, model: model)
        return response
    }
}
