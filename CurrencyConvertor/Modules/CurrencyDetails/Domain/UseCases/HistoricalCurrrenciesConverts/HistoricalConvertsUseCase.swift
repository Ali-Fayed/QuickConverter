//
//  HistoricalConvertsUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import Foundation
import RxCocoa
import RxSwift
class HistoricalConvertsUseCase: HistoricalDetailsUseCaseProtocol {
    typealias returnType = Observable<[HistoricalConvertsDataModel]>
    private let currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol
    init(currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol) {
        self.currencyDetailsRepoProtocol = currencyDetailsRepoProtocol
    }
    func excute(date: String, symbols: String, base: String) -> returnType {
        return currencyDetailsRepoProtocol.getHistoricalConverts(date: date, symbols: symbols, base: base)
    }
}
