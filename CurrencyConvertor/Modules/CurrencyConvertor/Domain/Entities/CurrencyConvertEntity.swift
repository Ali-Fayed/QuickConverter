//
//  CurrencyConvertEntity.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
// MARK: - CurrencyConvertEntity
struct CurrencyConvertEntity: Codable {
    let date: String
    let info: Info
    let query: Query
    let result: Double
    let success: Bool
}
// MARK: - Info
struct Info: Codable {
    let rate: Double
    let timestamp: Int
}

// MARK: - Query
struct Query: Codable {
    let amount: Int
    let from, to: String
}
