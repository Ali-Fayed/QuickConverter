//
//  APIError.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
struct APIError: Error, Codable {
    var errors: Errors?
    var customError: CustomError?
    init(_ customError: CustomError?) {
        self.customError = customError
    }
    init(_ errors: Errors) {
        self.errors = errors
    }
    enum CodingKeys: String, CodingKey {
        case errors
        case customError
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errors = try! values.decode(Errors.self, forKey: .errors)
        customError = try? values.decode(CustomError.self, forKey: .customError)
    }
}
// MARK: - Errors
struct Errors: Codable {
    let code: Int
    let type, info: String
}
