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
        return ["apikey": "H6Kiod4eDoLtKnCP2dD061m2Mc8taG5V"]
    }
    var method: HttpMethod {
        return .get
    }
}
