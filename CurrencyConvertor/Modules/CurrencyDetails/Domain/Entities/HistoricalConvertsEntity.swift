//
//  HistoricalConvertsEntity.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
struct HistoricalConvertsEntity: Codable {
    let rates: [String: [String: Double]]?
    let base: String?
}
