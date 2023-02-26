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
    // MARK: - Properties
    private let currencyDetailsUseCase: CurrencyDetailsUseCaseProtocol
    // MARK: - Rx Properties
    private var disposeBag = DisposeBag()
    let loadingIndicatorRelay = BehaviorRelay<Bool>(value: true)
    let currencyModelSubject = PublishSubject<[FamousCurrenciesDataModel]>()
    let convertsLastThreeDaysSubject = PublishSubject<[HistoricalConvertsDataModel]>()
    let apiErrorSubject = PublishSubject<APIError>()
    // MARK: - Properties
    var historicalModel = [HistoricalConvertsDataModel]()
    var currencyModel = [FamousCurrenciesDataModel]()
    var fromCurrencyValue: String = ""
    var fromCurrencyCode: String = ""
    var toCurrencyCode: String = ""
    var toCurrencyValue: String = ""
    // MARK: - initalizer
    init(currencyDetailsUseCase: CurrencyDetailsUseCaseProtocol) {
        self.currencyDetailsUseCase = currencyDetailsUseCase
    }
    // MARK: - Methods
    func fetchPopularConvertRates() {
        loadingIndicatorRelay.accept(true)
        currencyDetailsUseCase.fetchFamousConvertedCurrency(symbols: Constants.famousCurrencies, base: Constants.euroSymbol)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.currencyModelSubject.onNext(model)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.apiErrorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func fetchHistoricalConverts(date: String, symbols: String, base: String) {
        loadingIndicatorRelay.accept(true)
        currencyDetailsUseCase.fetchHistoricalDetails(date: date, symbols: symbols, base: self.fromCurrencyCode)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                guard let convertedCurrency = model.first else {return}
                self.mapLastThreeDaysConverts(model: convertedCurrency, date: date)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.apiErrorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func mapLastThreeDaysConverts(model: HistoricalConvertsDataModel, date: String) {
        self.historicalModel.append(HistoricalConvertsDataModel(fromCurrencySymbol: self.fromCurrencyValue, fromCurrencyValue: self.fromCurrencyCode, toCurrencySymobl: self.toCurrencyCode, toCurrencyValue: model.toCurrencyValue, dateString: date))
        if self.historicalModel.count == 3 {
            self.convertsLastThreeDaysSubject.onNext(self.historicalModel)
        }
    }
    func fetchLastThreeDaysConverts() {
        for date in getLastThreeDays() {
            self.fetchHistoricalConverts(date: date, symbols: "\(self.fromCurrencyCode),\(self.toCurrencyCode)", base: Constants.euroSymbol)
        }
    }
    // MARK: - Other
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
