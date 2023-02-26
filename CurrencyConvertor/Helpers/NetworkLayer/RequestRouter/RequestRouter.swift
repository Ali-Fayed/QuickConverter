//
//  RequestRouter.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
enum RequestRouter: BaseRouter {
    //MARK: - Properties
    case currencySymbols
    case convertCurrency(to: String, from: String, amount: String)
    case latestCurrencyRates(symbol: String, base: String)
    case timeSeriesCurrencyRates(startDate: String, endDate: String, base: String, symbols: String)
    //MARK: - Path
    var path: String {
        switch self {
        case .currencySymbols:
            return "/fixer/symbols"
        case .convertCurrency:
            return "/fixer/convert"
        case .latestCurrencyRates:
            return "/fixer/latest"
        case .timeSeriesCurrencyRates:
            return "/fixer/timeseries"
        }
    }
    //MARK: - Parameters or Body
    var parameter: HttpParameters? {
        switch self {
        case .currencySymbols:
            return nil
        case .convertCurrency(to: let to, from: let from, amount: let amount):
            return ["to": to, "from": from, "amount": amount]
        case .latestCurrencyRates(symbol: let symbol, base: let base):
            return ["base": base, "symbols": symbol]
        case .timeSeriesCurrencyRates(startDate: let startDate, endDate: let endDate, base: let base, symbols: let symbols):
            return ["start_date": startDate, "end_date": endDate, "base": base, "symbols": symbols]
        }
    }
}
