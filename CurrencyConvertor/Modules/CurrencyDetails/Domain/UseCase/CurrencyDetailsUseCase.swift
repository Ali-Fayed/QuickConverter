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
    func fetchHistoricalDetails(date: String, to: String, from: String) -> Observable<CurrencyDetailsDataModel> {
        return currencyDetailsRepoProtocol.getHistoricalConverts(date: date, to: to, from: from)
    }
    func fetchFamousConvertedCurrency(fromSymbol: String, toSymbol: String, value: String) -> Observable<CurrencyDetailsDataModel> {
        return currencyDetailsRepoProtocol.fetchFamousConvertedCurrency(fromSymbol: fromSymbol, toSymbol: toSymbol, value: value)
    }
}
