//
//  CurrencyConvertorRepoProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
protocol CurrencyConvertorRepoProtocol {
    typealias symbolsReturnType = Observable<CurrencySymbolsDataModel>
    typealias convertsReturnType = Observable<ConvertedCurrencyDataModel>
    func getCurrencySymbols() -> symbolsReturnType
    func getConvertedCurrency(from: String, to: String, ammout: String) -> convertsReturnType
}
