//
//  HistoricalConvertsUseCaseTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
final class HistoricalConvertsUseCaseTests: XCTestCase {
    var disposeBag: DisposeBag!
    /// Sut = System Under Test
    var sut: HistoricalConvertsUseCase!
    /// Mock = Fake injection
    var mockRemoteService: CurrencyDetailsMocks!
    override func setUp() {
        super.setUp()
        mockRemoteService = CurrencyDetailsMocks()
        sut = HistoricalConvertsUseCase(currencyDetailsRepoProtocol: mockRemoteService)
        disposeBag = DisposeBag()
    }
    override func tearDown() {
        mockRemoteService = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    func testFetchCurrencyHistoricalConverts() {
        // Given
        _ = mockRemoteService.getHistoricalConverts(startDate: "2023-02-25", endDate: "2023-02-27", base: "USD", symbols: "EGP")
        guard let mockOutput = mockRemoteService.hisoticalConvertsResult else {return}
        let promise = XCTestExpectation(description: "historical converts is fetched")
        // When
        sut.excute(startDate: "2023-02-25", endDate: "2023-02-27", base: "USD", symbols: "EGP")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] converts in
                // Then
                guard let self = self else {return}
                XCTAssertTrue(self.mockRemoteService.fetchHistoicalConvertsCalled)
                XCTAssertNotNil(converts)
                XCTAssertNotNil(mockOutput)
                XCTAssertEqual(converts.count, 3)
                XCTAssertEqual(converts.count, mockOutput.count)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                XCTAssertNotNil(formatter.date(from: converts[0].dateString), "Date string should be in format yyyy-MM-dd")
                XCTAssertEqual(converts[0].fromCurrencySymbol.count, 3)
                XCTAssertEqual(converts[0].fromCurrencySymbol.count, 3)
                XCTAssertEqual(converts[0].fromCurrencySymbol.count, mockOutput[0].fromCurrencySymbol.count)
                XCTAssertEqual(converts[0].fromCurrencySymbol.count, mockOutput[0].fromCurrencySymbol.count)
                promise.fulfill()
            }, onError: { _ in
                XCTFail("Fail to fetch the converts last three days")
            }).disposed(by: disposeBag)
        self.wait(for: [promise], timeout: 3.0)
    }
}
