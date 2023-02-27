//
//  CurrencyConvertorRemoteInterface.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import RxSwift
/// - Description: Interface For Remote Layer Contains The Must Implement Methods
protocol CurrencyConvertorRemoteInterface {
    /// Return Type ->  Store The Return Value in a Well Written Convention
    typealias symbolsReturnType = Observable<CurrencySymbolsEntity>
    typealias CurrencyConvertReturnType = Observable<CurrencyConvertEntity>
    /// Excute -> Excute The Remote Responsibilties
    func fetchCurrencySymbols() -> symbolsReturnType
    func fetchCurrencyConverts(from: String, to: String, ammout: String) -> CurrencyConvertReturnType
}
