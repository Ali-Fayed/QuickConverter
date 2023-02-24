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
    private var disposeBag = DisposeBag()
    let loadingIndicatorRelay = BehaviorRelay<Bool>(value: true)
    let currencySympolsSubject = PublishSubject<CurrencySympols>()
    func fetchCurrencySympols() {
        loadingIndicatorRelay.accept(true)
        let result = NetworkingManger.shared.performRequest(router: RequestRouter.symbols, model: CurrencySympols.self)
        result
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.currencySympolsSubject.onNext(model)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.currencySympolsSubject.onError(error)
        }).disposed(by: disposeBag)
    }
}
