//
//  FamousCurrenciesUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import RxSwift
class FamousCurrenciesUseCase: FamousCurrenciesUseCaseInterface {
    // MARK: - Properties
    typealias returnType = Observable<[FamousCurrenciesDataModel]>
    private let currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol
    // MARK: - Intializer
    init(currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol) {
        self.currencyDetailsRepoProtocol = currencyDetailsRepoProtocol
    }
    // MARK: - Use Case Excution Method
    /// - Description: Send Use Case Value to The Repository
    func excute(symbols: String, base: String) -> returnType {
        return currencyDetailsRepoProtocol.getFamousConvertes(symbols: symbols, base: base)
    }
}
