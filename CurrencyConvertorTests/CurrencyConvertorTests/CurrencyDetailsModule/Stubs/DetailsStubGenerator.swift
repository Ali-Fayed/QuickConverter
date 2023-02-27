//
//  DetailsStubGenerator.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
@testable import CurrencyConvertor
class DetailsStubGenerator {
    func stubHistoricalConverts() -> HistoricalConvertsEntity? {
        guard let path = Bundle.historicalUnitTests.path(forResource: "HistoricalStubs", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let symbolsModel = try? decoder.decode(HistoricalConvertsEntity.self, from: data)
        return symbolsModel
    }
    func stubFamousCurrencyConverts() -> FamousCurrencyEntity? {
        guard let path = Bundle.famousCurrenciesUnitTests.path(forResource: "FamousCurrenciesStubs", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let symbolsModel = try? decoder.decode(FamousCurrencyEntity.self, from: data)
        return symbolsModel
    }
}
extension Bundle {
    public class var historicalUnitTests: Bundle {
        return Bundle(for: HistoricalConvertsUseCaseTests.self)
    }
    public class var famousCurrenciesUnitTests: Bundle {
        return Bundle(for: FamousCurrencyConvertsUseCaseTests.self)
    }
}
