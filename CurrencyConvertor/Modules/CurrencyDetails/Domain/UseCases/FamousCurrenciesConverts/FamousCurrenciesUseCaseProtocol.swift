//
//  CurrencyDetailsUseCaseProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import RxSwift
import Foundation
protocol FamousCurrenciesUseCaseProtocol {
    typealias returnType = Observable<[FamousCurrenciesDataModel]>
    func excute(symbols: String, base: String) -> returnType
}
