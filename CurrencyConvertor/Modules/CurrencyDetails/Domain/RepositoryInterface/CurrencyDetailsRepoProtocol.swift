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
    func getHistoricalConverts(date: String, to: String, from: String) -> Observable<CurrencyDetailsDataModel>
    func fetchFamousConvertedCurrency(fromSymbol: String, toSymbol: String, value: String) -> Observable<CurrencyDetailsDataModel>
}
