//
//  APIError.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
struct APIError: Error, Codable {
    var error: Errors?
    var customError: CustomError?
    init(_ customError: CustomError?) {
        self.customError = customError
    }
}
// MARK: - Errors
struct Errors: Codable {
    let code: Int
    let type, info: String?
}
