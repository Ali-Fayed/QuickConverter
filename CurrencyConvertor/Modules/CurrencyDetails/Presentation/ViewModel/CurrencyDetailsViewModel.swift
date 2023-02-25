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
    let currencyModelSubject = PublishSubject<[CurrencyModel]>()
    let convertsLastThreeDaysSubject = PublishSubject<[HistoricalDataModel]>()
    let apiErrorSubject = PublishSubject<APIError>()
    // MARK: - Properties
    var historicalModel = [HistoricalDataModel]()
    var currencyModel = [CurrencyModel]()
    var fromCurrencyValue: String = ""
    var fromCurrencyCode: String = ""
    var toCurrencyCode: String = ""
    var toCurrencyValue: String = ""
    // MARK: - initalizer
    init(currencyDetailsUseCase: CurrencyDetailsUseCaseProtocol) {
        self.currencyDetailsUseCase = currencyDetailsUseCase
    }
    // MARK: - Methods
    func fetchHistoricalConverts(date: String, symbols: String, base: String) {
        loadingIndicatorRelay.accept(true)
        currencyDetailsUseCase.fetchHistoricalDetails(date: date, symbols: symbols, base: base)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
              guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                let to = Array(model.rates.values)[0]
                self.appendLastThreeDaysHistory(dateStr: date, fromValue: self.fromCurrencyValue, toValue: String(to), fromSymbol: self.fromCurrencyCode, toSymbol: self.toCurrencyCode)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.apiErrorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func fetchFamousConverts() {
        loadingIndicatorRelay.accept(true)
        currencyDetailsUseCase.fetchFamousConvertedCurrency(symbols: Constants.famousCurrencies, base: Constants.euroSymbol)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                let keys = Array(model.rates.keys)
                let values  = Array(model.rates.values)
                for (key, value) in zip(keys, values) {
                    self.currencyModel.append(CurrencyModel(currencySymbol: key, currencyValue: String(value)))
                }
                self.currencyModelSubject.onNext(self.currencyModel)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.apiErrorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func appendLastThreeDaysHistory(dateStr: String, fromValue: String, toValue: String, fromSymbol: String, toSymbol: String) {
        let dispatchGroup = DispatchGroup()
        for date in getLastThreeDays() {
            dispatchGroup.enter()
            historicalModel.append(HistoricalDataModel(fromCurrencySymbol: fromSymbol, fromCurrencyValue: fromValue, toCurrencySymobl: toSymbol, toCurrencyValue: toValue, dateString: date))
            dispatchGroup.leave()
            print(historicalModel)
        }
        dispatchGroup.notify(queue: .main) {
            self.convertsLastThreeDaysSubject.onNext(self.historicalModel)
        }
    }
    func getLastThreeDaysConverts() {
        let dateStringArray = getLastThreeDays()
        self.fetchHistoricalConverts(date: dateStringArray[0], symbols: "\(self.fromCurrencyCode),\(self.toCurrencyCode)", base: Constants.euroSymbol)
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
