//
//  CurrencyDetailsRepoProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxCocoa
import RxSwift
protocol CurrencyDetailsRepoProtocol {
    typealias hisotricalRetunType = Observable<[HistoricalConvertsDataModel]>
    typealias famousReturnType = Observable<[FamousCurrenciesDataModel]>
    func getHistoricalConverts(date: String, symbols: String, base: String) -> hisotricalRetunType
    func getFamousConvertes(symbols: String, base: String) -> famousReturnType
}
