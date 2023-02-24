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
        return "http"
    }
    var baseURL: String {
        return "data.fixer.io"
    }
    var headers: HttpHeaders? {
        return ["Accept": "application/json"]
    }
}