//
//  Entities.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation

struct ChoosenUser {
    
    var id: Int
    var name: String
    var surname: String
    var email: String
    var phone: String
}

struct UserResponseData: Decodable {
    
    let id: Int
    let name, username, email, phone, website: String
    let address: Address
}

struct Address: Decodable {
    
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Decodable {
    
    let lat, lng: String
}
