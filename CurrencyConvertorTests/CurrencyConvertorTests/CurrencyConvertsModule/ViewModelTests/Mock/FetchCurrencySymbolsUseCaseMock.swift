//
//  FetchCurrencySymbolsUseCaseMock.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
class FetchCurrencySymbolsUseCaseMock: FetchCurrencySymbolsUseCaseProtocol {
    typealias returnType = Observable<CurrencySymbolsDataModel>
    enum Result {
        case success(CurrencySymbolsDataModel)
        case failure(APIError)
    }
    var result: Result = .failure(APIError(.general))
    func excute() -> returnType {
        switch result {
        case .success(let symbols):
            return Observable.just(symbols)
        case .failure(let error):
            return Observable.error(error)
        }
    }
}
