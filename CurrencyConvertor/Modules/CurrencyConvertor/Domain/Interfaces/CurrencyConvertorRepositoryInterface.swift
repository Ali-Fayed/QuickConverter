//
//  CurrencyConvertorRepositoryInterface.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import RxSwift
/// - Description:Repository Interface contatins the necessary logic
protocol CurrencyConvertorRepositoryInterface {
    /// Return Type ->  Store The Return Value in a Well Written Convention
    typealias symbolsReturnType = Observable<CurrencySymbolsDataModel>
    typealias convertsReturnType = Observable<ConvertedCurrencyDataModel>
    /// Two Methods -> Return the mapped new observable with only necessary data
    func getCurrencySymbols() -> symbolsReturnType
    func getConvertedCurrencyValue(from: String, to: String, ammout: String) -> convertsReturnType
}
