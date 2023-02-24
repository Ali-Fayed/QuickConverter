//
//  CustomError.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
enum CustomError: String, Codable {
    case noConnetion
    case general
    case serverError
    case decodingError
    case emptyResponse
}
extension CustomError {
    var errorDescription: String? {
        switch self {
        case .noConnetion:
            return "Check your internet connection."
        case .serverError:
            return "Server is unavailable."
        case .emptyResponse:
            return "Response is empty."
        case .decodingError:
            return "Decoding error."
        default:
            return "Error occured please try again later."
        }
    }
}

