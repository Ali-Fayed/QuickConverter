//
//  NetworkingManger.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
import RxSwift
public class NetworkingManger {
    static let shared = NetworkingManger()
    private lazy var jsonDecoder = JSONDecoder()
    func performRequest<T: Codable>(router: BaseRouter, model: T.Type, shouldCache: Bool = false) -> Observable<T> {
        //  Creating observable
        return Observable.create { [unowned self] observer in
            // Send error if network is no reachable
            guard NetworkReachability.isConnectedToNetwork() else {
                observer.onError(APIError(.noConnetion))
                return Disposables.create()
            }
            // Create URLSession dataTask
            let task = URLSession.shared.dataTask(with: buildRequest(router, shouldCache: false)) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else { return }
                guard let _data = data else {return}
                    let statusCode = httpResponse.statusCode
                    let url = httpResponse.url
                    print("URL: [\(url!)] , code: [\(statusCode)]")
                    do {
                        if (200...299).contains(statusCode) {
                            let dataResponse = try self.jsonDecoder.decode(T.self, from: _data)
                            observer.onNext(dataResponse)
                        } else if (400..<499) ~= statusCode {
                            self.decodeAPIError(jsonDecoder: self.jsonDecoder, _data: _data, observer: observer)
                        } else if statusCode < 500 {
                            observer.onError(APIError(.serverError))
                        } else {
                            observer.onNext(EmptyResponse() as! T)
                        }
                    } catch {
                        // Observer onError event
                        self.decodeAPIError(jsonDecoder: self.jsonDecoder, _data: _data, observer: observer)
                    }
                // Observer onCompleted event
                observer.onCompleted()
             }
            task.resume()
            // Return our disposable
            return Disposables.create {
                  task.cancel()
            }
        }
    }
    // MARK: - Error Handling
    private func decodeAPIError<T: Decodable>(jsonDecoder: JSONDecoder, _data: Data, observer: AnyObserver<T>) {
        do {
            let errorResponse = try jsonDecoder.decode(APIError.self, from: _data)
            observer.onError(errorResponse)
        } catch {
            observer.onError(APIError(.general))
        }
    }
    // MARK: - URLRequest Components Builder
    private func buildRequest(_ router: BaseRouter, shouldCache: Bool) -> URLRequest {
        var component: URLComponents = URLComponents()
        component.scheme = router.scheme
        component.host = router.baseURL
        component.path = router.path
        if let parameter = router.parameter {
            parameter.forEach {
                if component.queryItems == nil {
                    component.queryItems = []
                }
                component.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))
            }
        }
        var urlRequest = URLRequest(url: component.url!, cachePolicy: shouldCache ? .useProtocolCachePolicy : .reloadIgnoringLocalCacheData)
        urlRequest.httpMethod = router.method.rawValue
        print(urlRequest)
        if router.method == .post {
            confiqureBody(body: router.parameter, request: &urlRequest)
        }
        configureHeaders(headers: router.headers, request: &urlRequest)
        return urlRequest
   }
    private func confiqureBody(body: [String: Any]?, request: inout URLRequest) {
       guard let bodyDic = body else {
           return
       }
       guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyDic, options: []) else {
           return
       }
       request.httpBody = httpBody
   }
   private func configureHeaders(headers: [String: String]?, request: inout URLRequest) {
       headers?.forEach {
           request.setValue($0.value, forHTTPHeaderField: $0.key)
       }
   }
}
