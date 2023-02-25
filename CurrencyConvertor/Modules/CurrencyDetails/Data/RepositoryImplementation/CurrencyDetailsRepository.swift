//
//  CurrencyDetailsRepository.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxSwift
import RxCocoa
class CurrencyDetailsRepository: CurrencyDetailsRepoProtocol {
    private let currencyDetailsRemoteProtocol: CurrencyDetailsRemoteProtocol
    init(currencyDetailsRemoteProtocol: CurrencyDetailsRemoteProtocol) {
        self.currencyDetailsRemoteProtocol = currencyDetailsRemoteProtocol
    }
    func getHistoricalConverts(date: String, symbols: String, base: String) -> Observable<CurrencyDetailsDataModell> {
        return currencyDetailsRemoteProtocol.fetchHistoricalCurrencyConverts(date: date, symbols: symbols, base: base)
            .map { CurrencyDetailss(rates: $0.rates) }
            .asObservable()
    }
    func fetchFamousConvertedCurrency(symbols: String, base: String) -> Observable<CurrencyDetailsDataModel> {
        currencyDetailsRemoteProtocol.fetchFamousConvertedCurrency(symbols: symbols, base: base)
            .map { CurrencyDetails(rates: $0.rates!) }
           .asObservable()
    }
}
