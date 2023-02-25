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
    func getHistoricalConverts(date: String, symbols: String, base: String) -> Observable<CurrencyDetailsDataModell>
    func fetchFamousConvertedCurrency(symbols: String, base: String) -> Observable<CurrencyDetailsDataModel>
}
