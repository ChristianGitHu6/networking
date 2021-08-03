//
//  ErrorModel.swift
//  Networking
//
//  Created by Anna on 8/1/21.
//

import Foundation

public class CustomError : Codable{
    var errorState: ErrorCase = .none
    var code: Int
    var msg: String
    var params:ParamsModel?
   
    
    enum CodingKeys: String, CodingKey {
        case code
        case msg
        case params
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decodeIfPresent(Int.self, forKey: .code) ?? 0
        msg = try container.decodeIfPresent(String.self, forKey: .msg) ?? ""
        params = try container.decodeIfPresent(ParamsModel.self, forKey: .params) ?? nil
    }
    
    init(code: Int, msg: String) {
        self.code = code
        self.msg = msg
    }
}

class ParamsModel : Codable{
    var errors: ErrorFieldsModel?
    
    enum CodingKeys: String, CodingKey {
        case errors
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        errors = try container.decodeIfPresent(ErrorFieldsModel.self, forKey: .errors) ?? nil
    }
}

class ErrorFieldsModel : Codable{
    var name: InsideField?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(InsideField.self, forKey: .name) ?? nil
    }
}

class InsideField : Codable{
    var message: String?
    var reason: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case reason
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? nil
        reason = try container.decodeIfPresent(String.self, forKey: .reason) ?? nil
    }
}

