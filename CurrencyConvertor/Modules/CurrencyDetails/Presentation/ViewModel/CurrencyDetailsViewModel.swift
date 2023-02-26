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
    var fromCurrencySymbol: String = ""
    var toCurrencySymbol: String = ""
    var fromCurrencyValue: String = ""
    // MARK: - initalizer
    init(historicalConvertsUseCase: HistoricalDetailsUseCaseProtocol, famousCurrenciesConvertsUseCase: FamousCurrenciesUseCaseProtocol) {
        self.historicalConvertsUseCase = historicalConvertsUseCase
        self.famousCurrenciesConvertsUseCase = famousCurrenciesConvertsUseCase
    }
    // MARK: - Famous Converts
    func fetchFamousTenCurrencyConverts() {
        loadingIndicatorRelay.accept(true)
        famousCurrenciesConvertsUseCase.excute(symbols: Constants.famousCurrencies, base: fromCurrencySymbol)
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
    func fetchHistoricalConvertsByDate(date: String, symbol: String, base: String) {
        loadingIndicatorRelay.accept(true)
        historicalConvertsUseCase.excute(date: date, symbols: symbol, base: base)
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
        let toValue = convertBaseRate(Double(fromCurrencyValue) ?? 1.0, by: Double(model.toCurrencyValue) ?? 1.0)
        historicalModel.append(HistoricalConvertsDataModel(fromCurrencySymbol: fromCurrencyValue, fromCurrencyValue: fromCurrencySymbol, toCurrencySymobl: toCurrencySymbol, toCurrencyValue: toValue, dateString: date))
        if self.historicalModel.count == 3 {
            self.historicalConvertsSubject.onNext(self.historicalModel)
        }
    }
    func fetchLastThreeDaysHistoricalConverts() {
        for date in getLastThreeDays() {
            self.fetchHistoricalConvertsByDate(date: date, symbol: self.toCurrencySymbol, base: self.fromCurrencySymbol)
        }
    }
    // MARK: - Helper Methods
    func getLastThreeDays() -> [String] {
        var datesData = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatString
        for i in 0...2 {
            let lastWeekDate = Calendar.current.date(byAdding: .day, value: -i, to: Date())
            let dateStr: String = dateFormatter.string(from: lastWeekDate ?? Date())
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
    func convertBaseRate(_ baseRate: Double, by factor: Double) -> String {
        let convertedRate = baseRate * factor
        return String(format: "%.2f", convertedRate)
    }
}
