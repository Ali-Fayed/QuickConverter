//
//  CurrencyDetailsUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxCocoa
import RxSwift
class CurrencyDetailsUseCase: CurrencyDetailsUseCaseProtocol {
    private let currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol
    init(currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol) {
        self.currencyDetailsRepoProtocol = currencyDetailsRepoProtocol
    }
    func fetchHistoricalDetails(date: String, symbols: String, base: String) -> Observable<CurrencyDetailsDataModell> {
        return currencyDetailsRepoProtocol.getHistoricalConverts(date: date, symbols: symbols, base: base)
    }
    func fetchFamousConvertedCurrency(symbols: String, base: String) -> Observable<CurrencyDetailsDataModel> {
        return currencyDetailsRepoProtocol.fetchFamousConvertedCurrency(symbols: symbols, base: base)
    }
}
