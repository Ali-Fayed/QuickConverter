//
//  CurrencyDetailsViewModel.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
import RxCocoa
class CurrencyDetailsViewModel {
    // MARK: - UseCases
    private let historicalConvertsUseCase: HistoricalDetailsUseCaseProtocol
    private let famousCurrenciesConvertsUseCase: FamousCurrenciesUseCaseProtocol
    // MARK: - Rx Properties
    private var disposeBag = DisposeBag()
    let loadingIndicatorRelay = BehaviorRelay<Bool>(value: true)
    let famousConvertsSubject = PublishSubject<[FamousCurrenciesDataModel]>()
    let historicalConvertsSubject = PublishSubject<[HistoricalConvertsDataModel]>()
    let errorSubject = PublishSubject<APIError>()
    // MARK: - Data Properties
    private var historicalModel = [HistoricalConvertsDataModel]()
    private var currencyModel = [FamousCurrenciesDataModel]()
    // MARK: - Passed Currency Data
    var fromCurrencyValue: String = ""
    var fromCurrencyCode: String = ""
    var toCurrencyCode: String = ""
    var toCurrencyValue: String = ""
    // MARK: - initalizer
    init(historicalConvertsUseCase: HistoricalDetailsUseCaseProtocol, famousCurrenciesConvertsUseCase: FamousCurrenciesUseCaseProtocol) {
        self.historicalConvertsUseCase = historicalConvertsUseCase
        self.famousCurrenciesConvertsUseCase = famousCurrenciesConvertsUseCase
    }
    // MARK: - Famous Converts
    func fetchFamousTenCurrencyConverts() {
        loadingIndicatorRelay.accept(true)
        famousCurrenciesConvertsUseCase.excute(symbols: Constants.famousCurrencies, base: Constants.euroSymbol)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.famousConvertsSubject.onNext(model)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.errorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    // MARK: - Historical Converts
    func fetchHistoricalConvertsByDate(date: String, symbols: String, base: String) {
        loadingIndicatorRelay.accept(true)
        historicalConvertsUseCase.excute(date: date, symbols: symbols, base: Constants.euroSymbol)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                guard let convertedCurrency = model.first else {return}
                self.mapLastThreeDays(model: convertedCurrency, date: date)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.errorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func mapLastThreeDays(model: HistoricalConvertsDataModel, date: String) {
        self.historicalModel.append(HistoricalConvertsDataModel(fromCurrencySymbol: self.fromCurrencyValue, fromCurrencyValue: self.fromCurrencyCode, toCurrencySymobl: self.toCurrencyCode, toCurrencyValue: model.toCurrencyValue, dateString: date))
        if self.historicalModel.count == 3 {
            self.historicalConvertsSubject.onNext(self.historicalModel)
        }
    }
    func fetchLastThreeDaysHistoricalConverts() {
        for date in getLastThreeDays() {
            self.fetchHistoricalConvertsByDate(date: date, symbols: "\(self.fromCurrencyCode),\(self.toCurrencyCode)", base: Constants.euroSymbol)
        }
    }
    // MARK: - Helper Methods
    func getLastThreeDays() -> [String] {
        var datesData = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatString
        for i in 0...2 {
            let lastWeekDate = Calendar.current.date(byAdding: .day, value: -i, to: Date())
            let dateStr:String = dateFormatter.string(from: lastWeekDate!)
            datesData.append(dateStr)
        }
        return datesData
    }
    func convertRateDetailsString(fromValue: String, fromSymbol: String, toValue: String, toSymbol: String) -> String {
        return "\(fromValue) \(fromSymbol) -> \(toValue) \(toSymbol)"
    }
    func presenetedDate(dateString: String) -> String {
        return "\(Constants.onKey) \(dateString)"
    }
}
