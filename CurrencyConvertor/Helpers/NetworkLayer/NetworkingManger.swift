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
    private func verifyStatusCodes<T: Decodable>(statusCode: Int, data: Data) throws -> (T) {
        switch statusCode {
           case (200...299):
            return try self.decodeResponse(jsonDecoder: jsonDecoder, data: data)
          case (400...499):
            throw self.decodeError(jsonDecoder: jsonDecoder, data: data)
          case 429, 104:
            throw APIError(.tooManyRequests)
          case (500...600):
            throw APIError(.serverError)
          default:
            throw self.decodeError(jsonDecoder: jsonDecoder, data: data)
        }
    }
    // MARK: - Response Decoder
    private func decodeResponse<T: Decodable>(jsonDecoder: JSONDecoder, data: Data) throws -> T {
        do {
            let reponse = try self.jsonDecoder.decode(T.self, from: data)
            return reponse
        } catch {
            throw APIError(.general)
        }
    }
    // MARK: - Error Decoder
    private func decodeError(jsonDecoder: JSONDecoder, data: Data) -> APIError {
        do {
            let errorResponse = try jsonDecoder.decode(APIError.self, from: data)
            return errorResponse
        } catch {
            return APIError(.general)
        }
    }
}
