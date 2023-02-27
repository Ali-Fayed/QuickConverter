//
//  NetworkingManger.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
import RxCocoa
class NetworkingManger {
    static let shared = NetworkingManger()
    private lazy var jsonDecoder = JSONDecoder()
    /// - Description:Generic Network Layer Returns an Observable with Built in Router
    /// - Parameters:
    ///   - router: enter here the router contains the endpoint you want to reques it
    ///   - model: enter here the model you want to decode to
    ///   - shouldCache: enter here the cache preference, default value is falss
    /// - Returns: Decoded model or error
    func performRequest<T: Codable>(router: BaseRouter, model: T.Type, shouldCache: Bool = false) -> Observable<T> {
        // handle no connection error
        guard NetworkReachability.isConnectedToNetwork() else {
            let networkErrorObservable =  Observable<T>.create { observer in
                observer.onError(APIError(.noConnetion))
                return Disposables.create()
            }
            return networkErrorObservable
        }
        // create disposable
        let requestRouter = router.asURLRequest(shouldCache: shouldCache)
        let requestObservable = URLSession.shared.rx.response(request: requestRouter)
        let disposable = requestObservable.map { [unowned self] response, data in
            let statusCode = response.statusCode
            let model: T = try self.verifyStatusCodes(statusCode: statusCode, data: data)
            return model
        }
        return disposable
    }
    // MARK: - Verify Status Code
    /// Handle all status codes states
    /// - Parameters:
    ///   - statusCode: integer number for status code
    ///   - data: data returned from the request
    /// - Returns: genric type T
    private func verifyStatusCodes<T: Decodable>(statusCode: Int, data: Data) throws -> (T) {
        switch statusCode {
           case (200...299):
            return try self.decodeResponse(jsonDecoder: jsonDecoder, data: data)
          case (400...499):
            throw self.decodeError(jsonDecoder: jsonDecoder, data: data)
          case (429):
            throw APIError(.tooManyRequests)
          case (500...600):
            throw APIError(.serverError)
          default:
            throw self.decodeError(jsonDecoder: jsonDecoder, data: data)
        }
    }
    // MARK: - Response Decoder
    /// Decoding the rsponse success
    /// - Parameters:
    ///   - jsonDecoder: json decoder
    ///   - data: data returned from the request
    /// - Returns: generic type T
    private func decodeResponse<T: Decodable>(jsonDecoder: JSONDecoder, data: Data) throws -> T {
        do {
            let reponse = try self.jsonDecoder.decode(T.self, from: data)
            return reponse
        } catch {
            throw decodeError(jsonDecoder: jsonDecoder, data: data)
        }
    }
    // MARK: - Error Decoder
    /// Decoding the rsponse error
    /// - Parameters:
    ///   - jsonDecoder: json decoder
    ///   - data: data returned from the request
    /// - Returns: API Error
    private func decodeError(jsonDecoder: JSONDecoder, data: Data) -> APIError {
        do {
            let errorResponse = try jsonDecoder.decode(APIError.self, from: data)
            return errorResponse
        } catch {
            return APIError(.general)
        }
    }
}
