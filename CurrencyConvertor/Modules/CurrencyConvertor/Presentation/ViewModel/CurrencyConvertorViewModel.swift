//
//  CurrencyConvertorViewModel.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 23/02/2023.
//
import Foundation
import RxSwift
import RxCocoa
class CurrencyConvertorViewModel {
    // MARK: - Properties
    private let currencyConvertorUseCase: CurrencyConvertorUseCaseProtocol
    // MARK: - Rx Properties
    private var disposeBag = DisposeBag()
    let loadingIndicatorRelay = BehaviorRelay<Bool>(value: true)
    let currencySympolsSubject = PublishSubject<SympolsDataModelProtocol>()
    let errorSubject = PublishSubject<APIError>()
    let latestRatesSubject = PublishSubject<String>()
    // MARK: - initalizer
    init(currencySymbolsUseCase: CurrencyConvertorUseCaseProtocol) {
        self.currencyConvertorUseCase = currencySymbolsUseCase
    }
    // MARK: - Methods
    func fetchCurrencySympols() {
        loadingIndicatorRelay.accept(true)
        currencyConvertorUseCase.fetchCurrencySymbols()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] sympols in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.currencySympolsSubject.onNext(sympols)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.errorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func fetchLatestRates(fromSympol: String, toSympol: String, value: String) {
        loadingIndicatorRelay.accept(true)
        currencyConvertorUseCase.fetchLatestCurrencyRates(from: fromSympol, to: toSympol)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                guard let convertedValue = self.convertedValue(model: model, fromSympol: fromSympol, toSympol: toSympol, value: value) else {return}
                self.latestRatesSubject.onNext(convertedValue)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.errorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func convertedValue(model: LatestRatesDataModelProtocol, fromSympol: String, toSympol: String, value: String) -> String? {
        guard let fromValue = model.rates[fromSympol] else {return ""}
        guard let toValue = model.rates[toSympol] else {return ""}
        guard let value = Double(value) else {return ""}
        let convertedString = convertCustomValues(fromValue: fromValue, toValue: toValue, valueToConvert: value)
        return convertedString
    }
    func convertCustomValues(fromValue: Double, toValue: Double, valueToConvert: Double) -> String {
         let convertValue = (toValue * valueToConvert) / fromValue
        return String(format: "%.3f", convertValue)
    }
}
