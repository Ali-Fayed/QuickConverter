//
//  FetchCurrencySymbolsUseCaseTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
class FetchCurrencySymbolsUseCaseTests: XCTestCase {
    var disposeBag: DisposeBag!
    /// Sut = System Under Test
    var sut: FetchCurrencySymbolsUseCase!
    /// Mock = Fake injection
    var mocks: CurrencyConvertorMocks!
    override func setUp() {
        super.setUp()
        mocks = CurrencyConvertorMocks()
        sut = FetchCurrencySymbolsUseCase(currencySymbolRepository: mocks)
        disposeBag = DisposeBag()
    }
    override func tearDown() {
        mocks = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    func testFetchCurrencySymbols() {
        // Given
        _ = mocks.getCurrencySymbols()
        guard let result = mocks.symbolResult?.sorted() else {return}
        let promise = XCTestExpectation(description: "symbols is fetched")
        // When
        sut.excute()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] sympols in
                // Then
                guard let self = self else {return}
                XCTAssertTrue(self.mocks.fetchSymbolsCalled)
                XCTAssertNotNil(sympols)
                XCTAssertNotNil(result)
                XCTAssertEqual(sympols.symbols.count, 170)
                XCTAssertEqual(sympols.symbols[0].count, result[0].count)
                XCTAssertEqual(sympols.symbols.count, result.count)
                XCTAssertEqual(sympols.symbols.sorted(), result)
                promise.fulfill()
            }, onError: { _ in
                XCTFail("Fail to fetch the symbols")
            }).disposed(by: disposeBag)
        self.wait(for: [promise], timeout: 3.0)
    }
}
