//
//  CurrencyConvertorUseCaseProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
protocol CurrencyConvertorUseCaseProtocol {
    func fetchCurrencySymbols() -> Observable<SympolsDataModelProtocol>
}
