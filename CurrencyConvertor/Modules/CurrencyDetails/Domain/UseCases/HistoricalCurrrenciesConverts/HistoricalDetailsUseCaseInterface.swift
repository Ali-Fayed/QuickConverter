//
//  HistoricalDetailsUseCaseInterface.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import RxSwift
/// - Description:UseCase Interface
protocol HistoricalDetailsUseCaseInterface {
    /// Return Type ->  Store The Return Value in a Well Written Convention
    typealias returnType = Observable<[HistoricalConvertsDataModel]>
    /// Excute -> Excute The Use Case Responsibilty
    func excute(startDate: String, endDate: String, base: String, symbols: String) -> returnType
}
