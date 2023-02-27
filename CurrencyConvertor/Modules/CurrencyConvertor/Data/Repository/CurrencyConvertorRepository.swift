//
//  CurrencyConvertorRepository.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import RxSwift
class CurrencyConvertorRepository: CurrencyConvertorRepositoryInterface {
    // MARK: - Properties
    typealias symbolsReturnType = Observable<CurrencySymbolsDataModel>
    typealias convertsReturnType = Observable<ConvertedCurrencyDataModel>
    private let currencySymbolService: CurrencyConvertorRemoteInterface
    // MARK: - Initializer
    init(currencySymbolService: CurrencyConvertorRemoteInterface) {
        self.currencySymbolService = currencySymbolService
    }
    // MARK: - Repository Methods
    /// Explain for this two methods: -> This layer responsibilty is map the data and send it to the use case
    /// - Returns: An observable of the type of the needed  mapped data
    func getCurrencySymbols() -> symbolsReturnType {
        return currencySymbolService.fetchCurrencySymbols()
            .flatMap { result -> Observable<CurrencySymbolsDataModel> in
                let symbols = Array(result.symbols.keys)
                return Observable.just(CurrencySymbolsDataModel(symbols: symbols.sorted()))
            }
    }
    /// - Parameters:
    ///   - from: enter here the from symbol like "USD" from the picker
    ///   - to: enter here the to symbol like "EGP" from the picker
    ///   - ammout: enter here the value you want to convert  like "1" from the text feild entry
    func getConvertedCurrencyValue(from: String, to: String, ammout: String) -> convertsReturnType {
        return currencySymbolService.fetchCurrencyConverts(from: from, to: to, ammout: ammout)
            .flatMap { result -> Observable<ConvertedCurrencyDataModel> in
                let convertedResult = String(format: Constants.twoNumbersDouble, result.result)
                return Observable.just(ConvertedCurrencyDataModel(convertedCurrencyResult: convertedResult))
            }
    }
}
