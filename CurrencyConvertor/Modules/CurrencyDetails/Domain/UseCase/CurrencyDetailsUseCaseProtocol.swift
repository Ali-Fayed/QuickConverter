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
    func fetchHistoricalDetails(date: String, to: String, from: String) -> Observable<CurrencyDetailsDataModel>
    func fetchFamousConvertedCurrency(fromSymbol: String, toSymbol: String, value: String) -> Observable<CurrencyDetailsDataModel>
}
