//
//  CurrencyConvertorUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
class CurrencyConvertorUseCase: CurrencyConvertorUseCaseProtocol {
    private let currencySymbolRepository: CurrencyConvertorRepoProtocol
    init(currencySymbolRepository: CurrencyConvertorRepoProtocol) {
        self.currencySymbolRepository = currencySymbolRepository
    }
    func fetchCurrencySymbols() -> Observable<SympolsDataModelProtocol> {
        return currencySymbolRepository.getCurrencySymbols()
            .map { CurrencySymbols(sympol: $0.symbols) }
            .asObservable()
    }
}
