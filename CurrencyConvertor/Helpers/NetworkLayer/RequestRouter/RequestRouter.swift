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
    case currenciesByDate(date: String, symbols: String, base: String)
    //MARK: - Path
    var path: String {
        switch self {
        case .currencySymbols:
            return "/fixer/symbols"
        case .convertCurrency:
            return "/fixer/convert"
        case .latestCurrencyRates:
            return "/fixer/latest"
        case .currenciesByDate(let date, _ , _):
            return "/fixer/\(date)"
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
        case .currenciesByDate(_ , let symbols, let base):
            return ["symbols": symbols, "base": base]
        }
    }
}
