//
//  CurrencySympols.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
struct CurrencySympols: Codable {
    let success: Bool
    let symbols: [String: String]
}
