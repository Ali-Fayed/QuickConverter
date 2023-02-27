//
//  CurrencyConvertorViewModel.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 23/02/2023.
//
import RxSwift
import RxRelay
class CurrencyConvertorViewModel {
    // MARK: - Use Cases
    private let currencySymbolsUseCase: CurrencySymbolsUseCaseInterface
    private let convertCurrencyUseCase: ConvertedCurrencyUseCaseInterface
    // MARK: - Rx Properties
    private var disposeBag = DisposeBag()
    let loadingIndicatorRelay = BehaviorRelay<Bool>(value: true)
    let currencySympolsSubject = PublishSubject<CurrencySymbolsDataModel>()
    let convertedCurrencySubject = PublishSubject<String>()
    let errorSubject = PublishSubject<APIError>()
    // MARK: - initalizer
    init(convertCurrencyUseCase: ConvertedCurrencyUseCaseInterface, currencySymbolsUseCase: CurrencySymbolsUseCaseInterface) {
        self.convertCurrencyUseCase = convertCurrencyUseCase
        self.currencySymbolsUseCase = currencySymbolsUseCase
    }
    // MARK: - View Model Methods
    /// - Description: bind the currency symbols to the pickers in the view controller, also handle loading and error
    func fetchCurrencySymbols() {
        loadingIndicatorRelay.accept(true)
        currencySymbolsUseCase.excute()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] symbols in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.currencySympolsSubject.onNext(symbols)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.errorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    /// - Description: Bind the converted currency value to the view controller, also handle loading and error
    /// - Parameters:
    ///   - fromSympol: enter here the from symbol like "USD" from the picker
    ///   - toSympol: enter here the to symbol like "EGP" from the picker
    ///   - amount: enter here the value you want to convert  like "1" from the text feild entry
    func fetchConvertedCurrency(fromSympol: String, toSympol: String, amount: String) {
        loadingIndicatorRelay.accept(true)
        convertCurrencyUseCase.excute(from: fromSympol, to: toSympol, amount: amount)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.convertedCurrencySubject.onNext(model.convertedCurrencyResult)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.errorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
}
