//
//  User.swift
//  Networking
//
//  Created by Anna on 8/2/21.
//

import Foundation

struct User : Codable {
    var data: UserData
}

struct UserData : Codable {
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String
}
