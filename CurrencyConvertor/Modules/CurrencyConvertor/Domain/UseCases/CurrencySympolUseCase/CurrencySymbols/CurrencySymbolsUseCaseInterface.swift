//
//  CurrencySymbolsUseCaseInterface.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import RxSwift
/// - Description: UseCase Interface
protocol CurrencySymbolsUseCaseInterface {
    /// Return Type ->  Store The Return Value in a Well Written Convention
    typealias returnType = Observable<CurrencySymbolsDataModel>
    /// Excute -> Excute The Use Case Responsibily
    func excute() -> returnType
}
