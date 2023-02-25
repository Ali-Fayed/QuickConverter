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
    func getHistoricalConverts(date: String, to: String, from: String) -> Observable<CurrencyDetailsDataModel> {
        return currencyDetailsRemoteProtocol.fetchHistoricalCurrencyConverts(date: date, to: to, from: from)
            .map { CurrencyDetails(rates: $0.rates) }
            .asObservable()
    }
    func fetchFamousConvertedCurrency(fromSymbol: String, toSymbol: String, value: String) -> Observable<CurrencyDetailsDataModel> {
        currencyDetailsRemoteProtocol.fetchFamousConvertedCurrency(fromSymbol: fromSymbol, toSymbol: toSymbol, value: value)
           .map { CurrencyDetails(rates: $0.rates) }
           .asObservable()
    }
}
