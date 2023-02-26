//
//  CurrencyConvertorRemoteProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
protocol CurrencyConvertorRemoteProtocol {
    typealias symbolsReturnType = Observable<CurrencySymbolsEntity>
    typealias CurrencyConvertReturnType = Observable<CurrencyConvertEntity>
    func fetchCurrencySymbols() -> symbolsReturnType
    func fetchCurrencyConverts(from: String, to: String, ammout: String) -> CurrencyConvertReturnType
}
