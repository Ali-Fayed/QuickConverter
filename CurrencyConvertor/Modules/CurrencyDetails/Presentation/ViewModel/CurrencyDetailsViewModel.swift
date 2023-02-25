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
    public let currencyModel: PublishSubject<[CurrencyModel]> = PublishSubject()
    let currencyHistoricalDetailsSubject = PublishSubject<CurrencyDetailsDataModel>()
    let convertsLastThreeDaysSubject = PublishSubject<[HistoricalDataModel]>()
    let apiErrorSubject = PublishSubject<APIError>()
    let convertedCurrencySubject = PublishSubject<String>()
    // MARK: - Properties
    var fromCurrencyValue: String = ""
    var fromCurrencyCode: String = ""
    var toCurrencyCode: String = ""
    var toCurrencyValue: String = ""
    var historicalModel = [HistoricalDataModel]()
    // MARK: - initalizer
    init(currencyDetailsUseCase: CurrencyDetailsUseCaseProtocol) {
        self.currencyDetailsUseCase = currencyDetailsUseCase
    }
    // MARK: - Methods
    func fetchHistoricalConverts(date: String, to: String, from: String) {
        loadingIndicatorRelay.accept(true)
        currencyDetailsUseCase.fetchHistoricalDetails(date: date, to: to, from: from)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                let to = Array(model.rates.values)[0]
                self.append(dateStr: date, fromValue: self.fromCurrencyValue, toValue: String(to), fromSymbol: self.fromCurrencyCode, toSymbol: self.toCurrencyCode)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.apiErrorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func fetchFamousConverts(date: String, to: String, from: String) {
        loadingIndicatorRelay.accept(true)
        currencyDetailsUseCase.fetchFamousConvertedCurrency(fromSymbol: from, toSymbol: to, value: "USD")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                let to = Array(model.rates.values)[0]
                self.append(dateStr: date, fromValue: self.fromCurrencyValue, toValue: String(to), fromSymbol: self.fromCurrencyCode, toSymbol: self.toCurrencyCode)
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingIndicatorRelay.accept(false)
                self.apiErrorSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    func append(dateStr: String, fromValue: String, toValue: String, fromSymbol: String, toSymbol: String) {
        historicalModel.append(HistoricalDataModel(fromCurrencySymbol: fromSymbol, fromCurrencyValue: fromValue, toCurrencySymobl: toSymbol, toCurrencyValue: toValue, dateString: dateStr))
    }
    func today() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr: String = dateFormatter.string(from: NSDate() as Date)
        fetchHistoricalConverts(date: dateStr, to: toCurrencyCode, from: fromCurrencyCode)
    }
    func getLastThreeDaysConverts() {
        let dispatchGroup = DispatchGroup()
        today()
        let datesArray = getHistoricalDates()
        for dateString in datesArray {
            dispatchGroup.enter()
            fetchHistoricalConverts(date: dateString, to: toCurrencyCode, from: fromCurrencyCode)
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.convertsLastThreeDaysSubject.onNext(self.historicalModel)
        }
    }
    func getHistoricalDates() -> [String] {
        var datesData = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for  i in 0...1{
            let lastWeekDate = NSCalendar.current.date(byAdding: .day, value: -(1+i), to: NSDate() as Date)
            let dateStr:String = dateFormatter.string(from: lastWeekDate!)
            datesData.append(dateStr)
        }
        return datesData
    }
}
struct CurrencyModel {
    var currencySymbol: String
    var currencyValue: String
}
