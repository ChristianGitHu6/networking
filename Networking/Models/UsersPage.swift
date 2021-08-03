//
//  UsersPage.swift
//  Networking
//
//  Created by Anna on 8/2/21.
//

import Foundation

struct UsersPage : Codable {
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data: [UserData]
}
