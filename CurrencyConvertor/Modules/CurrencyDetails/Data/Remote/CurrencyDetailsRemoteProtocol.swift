//
//  CurrencyDetailsRemoteProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxCocoa
import RxSwift
protocol CurrencyDetailsRemoteProtocol {
    func fetchHistoricalCurrencyConverts(date: String, symbols: String, base: String) -> Observable<HistoricalConvertsEntity>
    func fetchFamousConvertedCurrency(symbols: String, base: String) -> Observable<CurrencyRatesEntity>
}
