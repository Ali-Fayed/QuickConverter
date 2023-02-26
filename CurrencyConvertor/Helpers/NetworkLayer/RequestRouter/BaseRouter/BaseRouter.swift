//
//  BaseRouter.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
extension BaseRouter {
    var scheme: String {
        return "https"
    }
    var baseURL: String {
        return "api.apilayer.com"
    }
    var headers: HttpHeaders? {
        return ["apikey": "6fWe5aCb8TBNzO3xIWNrZB9aNI1QvPZD"]
    }
    var method: HttpMethod {
        return .get
    }
}
