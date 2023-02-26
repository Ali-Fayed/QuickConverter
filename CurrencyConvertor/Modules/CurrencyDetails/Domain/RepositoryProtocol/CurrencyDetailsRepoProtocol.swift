//
//  CurrencyDetailsRepoProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxSwift
protocol CurrencyDetailsRepoProtocol {
    typealias hisotricalRetunType = Observable<[HistoricalConvertsDataModel]>
    typealias famousReturnType = Observable<[FamousCurrenciesDataModel]>
    func getHistoricalConverts(startDate: String, endDate: String, base: String, symbols: String) -> hisotricalRetunType
    func getFamousConvertes(symbols: String, base: String) -> famousReturnType
}
