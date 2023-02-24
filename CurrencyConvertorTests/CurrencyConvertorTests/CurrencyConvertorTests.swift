//
//  CurrencyConvertorTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 23/02/2023.
//
import XCTest
@testable import CurrencyConvertor
final class CurrencyConvertorTests: XCTestCase {
    var useCase: CurrencyConvertorUseCaseProtocol!
    var currencySymbolRepositoryMock: CurrencySymbolRepositoryMock!
    override func setUpWithError() throws {
        try super.setUpWithError()
        currencySymbolRepositoryMock = CurrencySymbolRepositoryMock()
        useCase = CurrencyConvertorUseCase(currencySymbolRepository: currencySymbolRepositoryMock)
    }
    override func tearDownWithError() throws {
        currencySymbolRepositoryMock = nil
        useCase = nil
        try super.tearDownWithError()
    }
    func testFetchCurrencySymbols() throws {
        // Given
        let expectation = self.expectation(description: "Currency symbols fetched")
        currencySymbolRepositoryMock.currencySymbols = [.init(code: "USD", name: "US Dollar")]
        // When
        _ = useCase.fetchCurrencySymbols()
            .subscribe(onNext: {
                expectation.fulfill()
            }, onError: {
                XCTFail("Unexpected error: \($0)")
                expectation.fulfill()
            })
        waitForExpectations(timeout: 5.0)
        // Then
        XCTAssertTrue(currencySymbolRepositoryMock.isFetchCurrencySymbolsCalled, "fetchCurrencySymbols was not called on the repository")
    }

}
