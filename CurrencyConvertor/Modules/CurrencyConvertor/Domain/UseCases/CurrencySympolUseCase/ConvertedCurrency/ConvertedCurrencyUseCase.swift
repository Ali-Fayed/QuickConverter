//
//  FetchConvertedCurrencyUseCase.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import RxSwift
class ConvertedCurrencyUseCase: ConvertedCurrencyUseCaseInterface {
    // MARK: - Properties
    typealias returnType = Observable<ConvertedCurrencyDataModel>
    private let currencySymbolRepository: CurrencyConvertorRepositoryInterface
    // MARK: - Intializer
    init(currencySymbolRepository: CurrencyConvertorRepositoryInterface) {
        self.currencySymbolRepository = currencySymbolRepository
    }
    // MARK: - Use Case Excution Method
    /// - Description: The use case send the return value to the repository
    /// - Parameters:
    ///   - from: enter here the from symbol like "USD" from the picker
    ///   - to: enter here the to symbol like "EGP" from the picker
    ///   - amount: enter here the value you want to convert  like "1" from the text feild entry
    func excute(from: String, to: String, amount: String) -> returnType {
        return currencySymbolRepository.getConvertedCurrencyValue(from: from, to: to, ammout: amount)
    }
}
