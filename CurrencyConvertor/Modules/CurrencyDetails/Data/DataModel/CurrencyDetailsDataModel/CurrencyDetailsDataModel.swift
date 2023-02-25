//
//  CurrencyDetailsDataModel.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import Foundation
protocol CurrencyDetailsDataModel {
    var rates: [String: Double] { get }
}
