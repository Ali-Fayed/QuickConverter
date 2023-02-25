//
//  RequestRouter.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
enum RequestRouter: BaseRouter {
    case symbols
    case convert(to: String, from: String, amount: String)
    case latest(to: String, from: String, base: String)
    case timeSeries(startDate: String, endDate: String)
    case date(date: String, to: String, from: String)
    //MARK: - Path
    var path: String {
        switch self {
        case .symbols:
            return "/fixer/symbols"
        case .convert:
            return "/fixer/convert"
        case .latest:
            return "/fixer/latest"
        case .timeSeries:
            return "/fixer/timeseries"
        case .date(let date, _ , _):
            return "/fixer/\(date)"
        }
    }
    //MARK: - HTTPMethod
    var method: HttpMethod {
        switch self {
        case .symbols, .convert, .latest, .timeSeries, .date:
            return .get
        }
    }
    //MARK: - Parameters or Body
    var parameter: HttpParameters? {
        switch self {
        case .symbols:
            return nil
        case .convert(to: let to, from: let from, amount: let amount):
            return ["to": to, "from": from, "amount": amount]
        case .latest(to: let to, from: let from, base: let base):
            return ["symbols": "\(from),\(to)", "base": base]
        case .timeSeries(startDate: let startDate, endDate: let endDate):
            return ["start_date": startDate, "end_date": endDate]
        case .date(_ , let to, let from):
            return ["symbols": "\(from),\(to)", "base": "USD"]
        }
    }
}
