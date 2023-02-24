//
//  LatestRatesDataModelProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
protocol LatestRatesDataModelProtocol {
    var rates: [String: Double] { get }
}
