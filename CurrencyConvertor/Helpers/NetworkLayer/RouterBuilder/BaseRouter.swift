//
//  BaseRouter.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
protocol BaseRouter {
    var baseURL: String {get}
    var scheme: String {get}
    var path: String {get}
    var method: HttpMethod { get }
    var headers: HttpHeaders? { get }
    var parameter: HttpParameters? { get}
}

extension BaseRouter {
    var scheme: String {
        return "https"
    }
    var baseURL: String {
        return "api.apilayer.com"
    }
    var headers: HttpHeaders? {
        return ["apikey": "MvT5ptBM1nc9Ccdo76ShjgfIMwz3hLFN"]
    }
}
