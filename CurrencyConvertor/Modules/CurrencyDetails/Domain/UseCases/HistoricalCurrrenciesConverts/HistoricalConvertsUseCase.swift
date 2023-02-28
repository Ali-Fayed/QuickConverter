//
//  HistoricalConvertsUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import RxSwift
class HistoricalConvertsUseCase: HistoricalDetailsUseCaseInterface {
    // MARK: - Properties
    typealias returnType = Observable<[HistoricalConvertsDataModel]>
    private let currencyDetailsRepoProtocol: CurrencyDetailsRepositoryInterface
    // MARK: - Intializer
    init(currencyDetailsRepoProtocol: CurrencyDetailsRepositoryInterface) {
        self.currencyDetailsRepoProtocol = currencyDetailsRepoProtocol
    }
    // MARK: - Use Case Excution Method
    /// - Description: Send Use Case Value to The Repository
    /// - Parameters:
    ///   - startDate: enter here the start days from 3 days ago as an example
    ///   - endDate: enter here today's date
    ///   - base: the base currency you want to transfer to it
    ///   - symbols: your selected currency to you want to convert to the base
    func excute(startDate: String, endDate: String, base: String, symbols: String) -> returnType {
        return currencyDetailsRepoProtocol.getHistoricalConverts(startDate: startDate, endDate: endDate, base: base, symbols: symbols)
    }
}
