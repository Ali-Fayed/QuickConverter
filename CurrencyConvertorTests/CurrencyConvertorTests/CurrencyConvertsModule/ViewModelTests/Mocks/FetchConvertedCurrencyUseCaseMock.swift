//
//  FetchConvertedCurrencyUseCaseMock.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
class FetchConvertedCurrencyUseCaseMock: ConvertedCurrencyUseCaseInterface {
    typealias returnType = Observable<ConvertedCurrencyDataModel>
    enum Result {
        case success(ConvertedCurrencyDataModel)
        case failure(APIError)
    }
    var result: Result = .failure(APIError(.general))
    func excute(from: String, to: String, amount: String) -> returnType {
        switch result {
        case .success(let dataModel):
            return Observable.just(dataModel)
        case .failure(let error):
            return Observable.error(error)
        }
    }
}
