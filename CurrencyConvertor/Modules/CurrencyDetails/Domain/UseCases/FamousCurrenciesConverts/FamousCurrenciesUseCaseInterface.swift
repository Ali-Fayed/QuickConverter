//
//  FamousCurrenciesUseCaseInterface.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import RxSwift
/// - Description:UseCase Interface
protocol FamousCurrenciesUseCaseInterface {
    /// Return Type ->  Store The Return Value in a Well Written Convention
    typealias returnType = Observable<[FamousCurrenciesDataModel]>
    /// Excute -> Excute The Use Case Responsibily
    func excute(symbols: String, base: String) -> returnType
}
