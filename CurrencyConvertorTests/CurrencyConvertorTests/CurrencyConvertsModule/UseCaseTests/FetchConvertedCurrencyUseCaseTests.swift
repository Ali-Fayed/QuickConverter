//
//  FetchConvertedCurrencyUseCaseTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
class FetchConvertedCurrencyUseCaseTests: XCTestCase {
    var disposeBag: DisposeBag!
    /// Sut = System Under Test
    var sut: FetchConvertedCurrencyUseCase!
    /// Mock = Fake injection
    var mockRemoteService: CurrencyConvertorMocks!
    override func setUp() {
        super.setUp()
        mockRemoteService = CurrencyConvertorMocks()
        sut = FetchConvertedCurrencyUseCase(currencySymbolRepository: mockRemoteService)
        disposeBag = DisposeBag()
    }
    override func tearDown() {
        mockRemoteService = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    func testFetchConvertedCurrency() {
        // Given
         _ = mockRemoteService.getConvertedCurrency(from: "USD", to: "EGP", ammout: "5")
        guard let convertedResults = mockRemoteService.convertedResults else {return}
        let promise = XCTestExpectation(description: "converted currencies is fetched")
        // When
        sut.excute(from: "USD", to: "EGP", amount: "5")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] converts in
                // Then
                guard let self = self else {return}
                XCTAssertTrue(self.mockRemoteService.fetchConvertedCalled)
                XCTAssertNotNil(converts)
                XCTAssertNotNil(convertedResults)
                XCTAssertEqual(converts.convertedCurrencyResult, convertedResults)
                XCTAssertEqual(converts.convertedCurrencyResult, "152.97")
                promise.fulfill()
            }, onError: { _ in
                XCTFail("Fail to fetch the converts")
            }).disposed(by: disposeBag)
        self.wait(for: [promise], timeout: 3.0)
    }
}
