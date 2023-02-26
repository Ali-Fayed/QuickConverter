//
//  CurrencyDetailsRemoteProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxSwift
protocol CurrencyDetailsRemoteProtocol {
    typealias hisotricalRetunType = Observable<HistoricalConvertsEntity>
    typealias famousReturnType = Observable<FamousCurrencyEntity>
    func fetchHistoricalConverts(startDate: String, endDate: String, base: String, symbols: String) -> hisotricalRetunType
    func fetchFamousConvertes(symbols: String, base: String) -> famousReturnType
}
