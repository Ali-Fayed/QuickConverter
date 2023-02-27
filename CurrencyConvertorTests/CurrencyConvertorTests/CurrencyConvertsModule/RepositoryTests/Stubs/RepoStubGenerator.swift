//
//  RepoStubGenerator.swift
//  CurrencyConvertorTests
//
//  Created by AliFayed on 27/02/2023.
//
import XCTest
@testable import CurrencyConvertor
class RepoStubGenerator {
    func stubSymbols() -> CurrencySymbolsEntity? {
        guard let path = Bundle.symbolUnitTest.path(forResource: "SymbolsStub", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let symbolsModel = try? decoder.decode(CurrencySymbolsEntity.self, from: data)
        return symbolsModel
    }
    func stubCurrencyConverts() -> CurrencyConvertEntity? {
        guard let path = Bundle.convertsUnitTest.path(forResource: "ConvertsStub", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let symbolsModel = try? decoder.decode(CurrencyConvertEntity.self, from: data)
        return symbolsModel
    }
}
extension Bundle {
    public class var symbolUnitTest: Bundle {
        return Bundle(for: CurrencyConvertorRepositoryTests.self)
    }
    public class var convertsUnitTest: Bundle {
        return Bundle(for: CurrencyConvertorRepositoryTests.self)
    }
}
