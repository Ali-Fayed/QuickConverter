//
//  CurrencySymbolRepositoryMock.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 24/02/2023.
//
@testable import CurrencyConvertor
class CurrencySymbolRepositoryMock: CurrencyConvertorRepository {
    var currencySymbols: [SympolsDataModelProtocol] = []
    var isFetchCurrencySymbolsCalled = false

    func fetchCurrencySymbols() -> Observable<[SympolsDataModelProtocol]> {
        isFetchCurrencySymbolsCalled = true
        return Observable.just(currencySymbols)
    }
}
