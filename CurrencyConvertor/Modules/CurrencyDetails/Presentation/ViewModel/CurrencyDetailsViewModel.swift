//
//  CurrencyDetailsViewModel.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
import RxRelay
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
    private func fetchHistoricalConvertsByDate(startDate: String, endDate: String, base: String, symbols: String) {
        loadingIndicatorRelay.accept(true)
        historicalConvertsUseCase.excute(startDate: startDate, endDate: endDate, base: base, symbols: symbols)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.historicalConvertsSubject.onNext(self.mapHistoricalDetails(model: model))
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.errorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    private func mapHistoricalDetails(model: [HistoricalConvertsDataModel]) -> [HistoricalConvertsDataModel] {
        self.historicalModel = model.map { [unowned self] data in
            var newData = data
            if newData.fromCurrencyValue.isEmpty {
                newData.fromCurrencyValue = self.fromCurrencyValue
            }
            let fromValue = Double(self.fromCurrencyValue) ?? 1.0
            let toValue = Double(newData.toCurrencyValue) ?? 1.0
            newData.toCurrencyValue = self.convertBaseRateToThePassedRate(fromValue, by: toValue)
            return newData
        }
        return historicalModel
    }
    func fetchLastThreeDaysHistoricalConverts() {
        let startData = getLastThreeDaysRange().0
        let endDate = getLastThreeDaysRange().1
        self.fetchHistoricalConvertsByDate(startDate: startData, endDate: endDate, base: fromCurrencySymbol, symbols: toCurrencySymbol)
    }
    // MARK: - Helper Methods
    private func getLastThreeDaysRange() -> (String, String) {
        var datesData = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatString
        for i in 0...2 {
            let lastWeekDate = Calendar.current.date(byAdding: .day, value: -i, to: Date())
            let dateStr: String = dateFormatter.string(from: lastWeekDate ?? Date())
            datesData.append(dateStr)
        }
        return (datesData[2], datesData[0])
    }
    private func convertBaseRateToThePassedRate(_ baseRate: Double, by factor: Double) -> String {
        let convertedRate = baseRate * factor
        return String(format: "%.2f", convertedRate)
    }
}
