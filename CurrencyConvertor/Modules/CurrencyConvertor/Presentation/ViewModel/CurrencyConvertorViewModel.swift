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
    // MARK: - Use Case
    private let fetchSymbolsUseCase: FetchCurrencySymbolsUseCaseProtocol
    private let convertCurrencyUseCase: FetchConvertedCurrencyUseCaseProtocol
    // MARK: - Rx Properties
    private var disposeBag = DisposeBag()
    let loadingIndicatorRelay = BehaviorRelay<Bool>(value: true)
    let currencySympolsSubject = PublishSubject<CurrencySymbolsDataModel>()
    let convertedCurrencySubject = PublishSubject<String>()
    let errorSubject = PublishSubject<APIError>()
    // MARK: - initalizer
    init(convertCurrencyUseCase: FetchConvertedCurrencyUseCaseProtocol, fetchSymbolsUseCase: FetchCurrencySymbolsUseCaseProtocol) {
        self.convertCurrencyUseCase = convertCurrencyUseCase
        self.fetchSymbolsUseCase = fetchSymbolsUseCase
    }
    // MARK: - Methods
    func fetchCurrencySympols() {
        loadingIndicatorRelay.accept(true)
        fetchSymbolsUseCase.excute()
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
    func fetchConvertedCurrency(fromSympol: String, toSympol: String, amount: String) {
        convertCurrencyUseCase.excute(from: fromSympol, to: toSympol, amount: amount)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.convertedCurrencySubject.onNext(model.convertedCurrencyResult)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.errorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
}
