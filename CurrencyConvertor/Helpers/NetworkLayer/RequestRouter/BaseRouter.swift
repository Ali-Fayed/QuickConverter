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
        return ["apikey": "X8vlRLdewguVjbOMSHX58py8zfP3OLmf"]
    }
    var method: HttpMethod {
        return .get
    }
}