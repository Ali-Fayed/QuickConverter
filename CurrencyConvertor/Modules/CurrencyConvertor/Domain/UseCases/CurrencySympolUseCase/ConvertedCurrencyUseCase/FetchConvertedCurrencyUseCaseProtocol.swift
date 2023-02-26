//
//  FetchConvertedCurrencyUseCaseProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import Foundation
import RxSwift
protocol FetchConvertedCurrencyUseCaseProtocol {
    typealias returnType = Observable<ConvertedCurrencyDataModel>
    func excute(from: String, to: String, amount: String) -> returnType
}
