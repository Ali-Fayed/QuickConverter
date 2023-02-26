//
//  CurrencyDetailsUseCaseProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import RxCocoa
import RxSwift
import Foundation
protocol CurrencyDetailsUseCaseProtocol {
    func fetchHistoricalDetails(date: String, symbols: String, base: String) -> Observable<[HistoricalConvertsDataModel]>
    func fetchFamousConvertedCurrency(symbols: String, base: String) -> Observable<[FamousCurrenciesDataModel]>
}
