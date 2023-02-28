//
//  CurrencyDetailsRepositoryInterface.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import RxSwift
/// - Description:Repository Interface contatins the necessary logic
protocol CurrencyDetailsRepositoryInterface {
    /// Return Type ->  Store The Return Value in a Well Written Convention
    typealias hisotricalRetunType = Observable<[HistoricalConvertsDataModel]>
    typealias famousReturnType = Observable<[FamousCurrenciesDataModel]>
    /// Two Methods -> Return the mapped new observable with only necessary data
    func getHistoricalConverts(startDate: String, endDate: String, base: String, symbols: String) -> hisotricalRetunType
    func getFamousConvertes(symbols: String, base: String) -> famousReturnType
}
