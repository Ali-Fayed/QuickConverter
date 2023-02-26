//
//  CurrencyDetailsUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
import RxCocoa
import RxSwift
class FamousCurrenciesUseCase: FamousCurrenciesUseCaseProtocol {
    typealias returnType = Observable<[FamousCurrenciesDataModel]>
    private let currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol
    init(currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol) {
        self.currencyDetailsRepoProtocol = currencyDetailsRepoProtocol
    }
    func excute(symbols: String, base: String) -> returnType {
        return currencyDetailsRepoProtocol.getFamousConvertes(symbols: symbols, base: base)
    }
}
