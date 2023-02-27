//
//  FamousCurrencyConvertsUseCaseTests.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
import RxSwift
@testable import CurrencyConvertor
final class FamousCurrencyConvertsUseCaseTests: XCTestCase {
    var disposeBag: DisposeBag!
    /// Sut = System Under Test
    var sut: FamousCurrenciesUseCase!
    /// Mock = Fake injection
    var mockRepo: CurrencyDetailsMocks!
    override func setUp() {
        super.setUp()
        mockRepo = CurrencyDetailsMocks()
        sut = FamousCurrenciesUseCase(currencyDetailsRepoProtocol: mockRepo)
        disposeBag = DisposeBag()
    }
    override func tearDown() {
        mockRepo = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    func testFetchFamousCurrencyRates() {
        // Given
        _ = mockRepo.getFamousConvertes(symbols: "EGP", base: "USD")
        guard let mockOutput = mockRepo.famousConvertsResult else {return}
        let promise = XCTestExpectation(description: "famous converts is fetched")
        // When
        sut.excute(symbols: "EGP", base: "USD")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] rates in
                // Then
                guard let self = self else {return}
                XCTAssertTrue(self.mockRepo.fetchFamousCurrenciesCalled)
                XCTAssertNotNil(mockOutput)
                XCTAssertNotNil(rates)
                XCTAssertEqual(mockOutput[0].currencySymbol.count, 3)
                XCTAssertEqual(mockOutput[0].currencySymbol.count, rates[0].currencySymbol.count)
                XCTAssertEqual(rates.count, 12)
                XCTAssertEqual(mockOutput.count, rates.count)
                promise.fulfill()
            }, onError: { _ in
                XCTFail("Fail to fetch the rates")
            }).disposed(by: disposeBag)
        self.wait(for: [promise], timeout: 3.0)
    }
}
