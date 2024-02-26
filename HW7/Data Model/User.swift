//
//  User.swift
//  HW7
//
//  Created by Jefferson Cuartas on 11/1/23.
//

import Foundation

struct User {
    var email: String
    var password: String
    var name: String
    
    init(email: String, password: String, name: String){
        self.email = email
        self.password = password
        self.name = name
    }
}
