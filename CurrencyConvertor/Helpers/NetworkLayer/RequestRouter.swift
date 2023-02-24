//
//  RequestRouter.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
enum RequestRouter: BaseRouter {
    case symbols
    case latest(from: String, to: String)
    //MARK: - Path
    var path: String {
        switch self {
        case .symbols:
            return "/api/symbols"
        case .latest:
            return "/api/2023-02-23"
        }
    }
    //MARK: - HTTPMethod
    var method: HttpMethod {
        switch self {
        case .symbols, .latest:
            return .get
        }
    }
    //MARK: - Parameters or Body
    var parameter: HttpParameters? {
        switch self {
        case .symbols:
            return ["access_key": ""]
        case .latest(let from, let to):
            return ["access_key": "", "symbols": "\(from),\(to)", "base": "EUR"]
        }
    }
}
