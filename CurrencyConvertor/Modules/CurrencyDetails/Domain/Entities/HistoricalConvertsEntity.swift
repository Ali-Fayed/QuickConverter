//
//  HistoricalConvertsEntity.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
/// - Description: Historical Converts Entity Stores The Remote Service Response
struct HistoricalConvertsEntity: Codable {
    let rates: [String: [String: Double]]?
    let base: String?
}
