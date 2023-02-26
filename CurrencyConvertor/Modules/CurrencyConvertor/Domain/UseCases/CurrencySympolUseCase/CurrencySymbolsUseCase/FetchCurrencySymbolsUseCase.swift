//
//  FetchCurrencySymbolsUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
class FetchCurrencySymbolsUseCase: FetchCurrencySymbolsUseCaseProtocol {
    typealias returnType = Observable<CurrencySymbolsDataModel>
    private let currencySymbolRepository: CurrencyConvertorRepoProtocol
    init(currencySymbolRepository: CurrencyConvertorRepoProtocol) {
        self.currencySymbolRepository = currencySymbolRepository
    }
    func excute() -> returnType {
        return currencySymbolRepository.getCurrencySymbols()
    }
}
