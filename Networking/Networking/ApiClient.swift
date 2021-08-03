//
//  ApiClient.swift
//  Networking
//
//  Created by Anna on 8/1/21.
//

import Foundation
import Alamofire

enum ErrorCase {
    case internetError
    case somethingWentWrongError
    case serverError
    case none
}

public enum APIResult<Success, Failure> where Failure : CustomError {
    /// A success, storing a `Success` value.
    case success(Success)

    /// A failure, storing a `Failure` value.
    case failure(CustomError)
}


class RequestModel {
    
    // MARK: - Properties
    var path: String {
        return ""
    }
    var parameters: Parameters {
        return [:]
    }
    var headers: [String: String] {
        return [:]
    }
    var method: HTTPMethod {
        return .get
    }
    var body: [String: Any?] {
        return [:]
    }
    
    var encoding: ParameterEncoding {
        return method == .post ? JSONEncoding.default : URLEncoding.default
    }
}

class APIClient {
    static var sharedInstace = APIClient()
    private let baseUrl = "https://reqres.in/api"

    func request<T: Codable>(with request: RequestModel,
                                  completition: @escaping(APIResult<T, CustomError>) -> Void){
        let path = "\(baseUrl)\(request.path)"
        var header = request.headers
        header["imtoken"] = testToken
        
        AF.request( path,
                    method: request.method,
                    parameters: request.parameters,
                    encoding: request.encoding,
                    headers: HTTPHeaders(header))
            .validate(statusCode: 200..<299)
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    self.handleSuccessCode(completition: completition, data: data)
                case .failure(_):
                    self.handleFailureCode(completition: completition, data: response.data)
                }
            })
    }
    
    private func handleSuccessCode<T: Codable>(completition: @escaping(APIResult<T, CustomError>) -> Void, data: Data){
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                completition(.success(object))
            }
        } catch {
            print("Faile decoding of \(T.self)")
            DispatchQueue.main.async {
                let error = CustomError(code: -1, msg: "Faile decoding of \(T.self)")
                error.errorState = .somethingWentWrongError
                completition(.failure(error))
            }
        }
    }
    
    private func handleFailureCode<T: Codable>(completition: @escaping(APIResult<T, CustomError>) -> Void, data: Data?){
        let customError = CustomError(code: -1, msg: "")
        customError.errorState = .somethingWentWrongError
        
        guard let data = data else {
            completition(.failure(customError))
            return
        }
        
        do {
            let object = try JSONDecoder().decode(CustomError.self, from: data)
            object.errorState = .serverError
            DispatchQueue.main.async {
                completition(.failure(object))
            }
        } catch {
            print("Faile decoding of \(CustomError.self)")
            DispatchQueue.main.async {
                completition(.failure(customError))
            }
        }
    }
}

let testToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIiwianRpIjoiMTE2MDcifQ.eyJpc3MiOiJodHRwOlwvXC9hZG1pbi5tZWRuZXQuYW0iLCJhdWQiOiJodHRwOlwvXC9hZG1pbi5tZWRuZXQuYW0iLCJqdGkiOiIxMTYwNyIsImlhdCI6MTYxMDYxODQ2NiwibmJmIjoxNjEwNjE4NTI2LCJleHAiOjE2MTIwNTg0NjYsInVpZCI6MTA0NSwic2lkIjoxMTYwNywibGV2ZWwiOjQsIm9zIjoidW5rbm93biIsImlwIjoiMTAuMC4wLjEiLCJhcGlLZXlJZCI6NiwiaG9zdCI6IjEwLjAuMC4xIiwidXVpZCI6IjAuMCJ9."
