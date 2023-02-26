//
//  HistoricalConvertsUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import Foundation
import RxSwift
class HistoricalConvertsUseCase: HistoricalDetailsUseCaseProtocol {
    typealias returnType = Observable<[HistoricalConvertsDataModel]>
    private let currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol
    init(currencyDetailsRepoProtocol: CurrencyDetailsRepoProtocol) {
        self.currencyDetailsRepoProtocol = currencyDetailsRepoProtocol
    }
    func excute(startDate: String, endDate: String, base: String, symbols: String) -> returnType {
        return currencyDetailsRepoProtocol.getHistoricalConverts(startDate: startDate, endDate: endDate, base: base, symbols: symbols)
    }
}
