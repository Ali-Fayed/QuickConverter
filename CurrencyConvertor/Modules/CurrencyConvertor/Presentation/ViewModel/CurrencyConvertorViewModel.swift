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
    let apiErrorSubject = PublishSubject<APIError>()
    let convertedCurrencySubject = PublishSubject<String>()
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
                self.apiErrorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func fetchLatestRates(fromSympol: String, toSympol: String, amount: String) {
        loadingIndicatorRelay.accept(true)
        currencyConvertorUseCase.fetchLatestCurrencyRates(from: fromSympol, to: toSympol, amount: amount)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.convertedCurrencySubject.onNext(model.convertedCurrencyResult)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.apiErrorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
}
