//
//  CurrencyConvertsViewModelTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
import RxTest
@testable import CurrencyConvertor
class CurrencyConvertsViewModelTests: XCTestCase {
    var viewModel: CurrencyConvertorViewModel!
    var fetchSymbolsUseCaseMock: FetchCurrencySymbolsUseCaseMock!
    var fetchConvertedCurrencyUseCaseMock: FetchConvertedCurrencyUseCaseMock!
    var disposeBag: DisposeBag!
    override func setUp() {
        super.setUp()
        fetchSymbolsUseCaseMock = FetchCurrencySymbolsUseCaseMock()
        fetchConvertedCurrencyUseCaseMock = FetchConvertedCurrencyUseCaseMock()
        viewModel = CurrencyConvertorViewModel(convertCurrencyUseCase: fetchConvertedCurrencyUseCaseMock, fetchSymbolsUseCase: fetchSymbolsUseCaseMock)
        disposeBag = DisposeBag()
    }
    override func tearDown() {
        viewModel = nil
        fetchSymbolsUseCaseMock = nil
        disposeBag = nil
        super.tearDown()
    }
    func testFetchCurrencySympols() {
        // Given
        let symbols = CurrencySymbolsDataModel(symbols: ["USD"])
        _ = fetchSymbolsUseCaseMock.excute()
        fetchSymbolsUseCaseMock.result = .success(symbols)
        let scheduler = TestScheduler(initialClock: 0)
        let currencySymbolsObserver = scheduler.createObserver(CurrencySymbolsDataModel.self)
        let errorObserver = scheduler.createObserver(APIError.self)
        // When
        viewModel.currencySympolsSubject.bind(to: currencySymbolsObserver).disposed(by: disposeBag)
        viewModel.errorSubject.bind(to: errorObserver).disposed(by: disposeBag)
        viewModel.fetchCurrencySympols()
        scheduler.start()
        // Then
        XCTAssertEqual(currencySymbolsObserver.events, [.next(0, symbols)])
    }
    func testFetchConvertedCurrency() {
        // Given
        let expectedCurrencyResult = "152.972935"
        _ = fetchConvertedCurrencyUseCaseMock.excute(from: "USD", to: "EGP", amount: "5")
        let expectedDataModel = ConvertedCurrencyDataModel(convertedCurrencyResult: expectedCurrencyResult)
        fetchConvertedCurrencyUseCaseMock.result = .success(expectedDataModel)
        // When
        viewModel.fetchConvertedCurrency(fromSympol: "USD", toSympol: "EUR", amount: "5")
        let expectation = XCTestExpectation(description: "Convert currency")

        // Then
        viewModel.convertedCurrencySubject.subscribe(onNext: { currencyResult in
            XCTAssertEqual(currencyResult, expectedCurrencyResult)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        viewModel.errorSubject.subscribe(onNext: { _ in
            XCTFail("Should not receive error")
            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 5.0)
    }
}
