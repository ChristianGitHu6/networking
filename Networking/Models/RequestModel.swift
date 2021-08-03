//
//  RequestModel.swift
//  Networking
//
//  Created by Anna on 8/3/21.
//

import Foundation
import Alamofire

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
