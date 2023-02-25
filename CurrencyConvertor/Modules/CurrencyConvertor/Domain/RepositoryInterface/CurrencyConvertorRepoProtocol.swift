//
//  CurrencyConvertorRepoProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
protocol CurrencyConvertorRepoProtocol {
    func getCurrencySymbols() -> Observable<SympolsDataModelProtocol>
    func getLatestCurrencyConvertedRates(from: String, to: String, ammout: String) -> Observable<ConvertedCurrencyDataModelProtocol>
}
