//
//  FetchConvertedCurrencyUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import Foundation
import RxSwift
class FetchConvertedCurrencyUseCase: FetchConvertedCurrencyUseCaseProtocol {
    typealias returnType = Observable<ConvertedCurrencyDataModel>
    private let currencySymbolRepository: CurrencyConvertorRepoProtocol
    init(currencySymbolRepository: CurrencyConvertorRepoProtocol) {
        self.currencySymbolRepository = currencySymbolRepository
    }
    func excute(from: String, to: String, amount: String) -> returnType {
        return currencySymbolRepository.getConvertedCurrency(from: from, to: to, ammout: amount)
    }
}
