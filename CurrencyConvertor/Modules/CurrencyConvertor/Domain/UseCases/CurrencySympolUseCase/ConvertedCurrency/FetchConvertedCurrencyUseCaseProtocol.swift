//
//  ConvertedCurrencyUseCaseInterface.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import Foundation
import RxSwift
/// - Description: UseCase Interface 
protocol ConvertedCurrencyUseCaseInterface {
    /// Return Type ->  Store The Return Value in a Well Written Convention
    typealias returnType = Observable<ConvertedCurrencyDataModel>
    /// Excute -> Excute The Use Case Responsibily
    func excute(from: String, to: String, amount: String) -> returnType
}
