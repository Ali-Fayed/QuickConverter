//
//  APIError.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
struct APIError: Error, Codable, Equatable {
    var message: String?
    var customError: CustomError?
    init(_ customError: CustomError?) {
        self.customError = customError
    }
}
