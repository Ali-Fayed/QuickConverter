//
//  RequestRouter.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
enum RequestRouter: BaseRouter {
    case symbols
    case latest
    //MARK: - Path
    var path: String {
        switch self {
        case .symbols:
            return "/api/symbols"
        case .latest:
            return "/api/latest"
        }
    }
    //MARK: - HTTPMethod
    var method: HttpMethod {
        switch self {
        case .symbols:
            return .get
        case .latest:
            return .get
        }
    }
    //MARK: - Parameters or Body
    var parameter: HttpParameters? {
        switch self {
        case .symbols:
            return nil
        case .latest:
            return nil
        }
    }
}
