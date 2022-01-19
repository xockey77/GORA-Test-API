//
//  Model.swift
//  GORA Test API
//
//  Created by username on 18.01.2022.
//

import Foundation

struct User: Decodable {
    var id: Int = 0
    var name: String = ""
    var username: String = ""
}

struct Album: Decodable {
    var userId: Int  = 0
    var id: Int = 0
    var title: String = ""
}

struct Photo: Decodable {
    var albumId: Int = 0
    var id: Int = 0
    var title: String = ""
    var url: String = ""
    var thumbnailUrl: String = ""
}
