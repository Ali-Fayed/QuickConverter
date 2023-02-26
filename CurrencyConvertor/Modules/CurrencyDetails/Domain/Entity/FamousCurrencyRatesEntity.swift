//
//  CurrencyRatesEntity.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
struct FamousCurrencyRatesEntity: Codable {
    let success: Bool?
    let timestamp: Int?
    let historical: Bool?
    let base, date: String?
    let rates: [String: Double]?
}
