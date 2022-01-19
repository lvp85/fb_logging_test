//
//  getdata.swift
//  FbloggigAccount
//
//  Created by Udagedara Dehigama on 2022/01/18.
//

import Foundation
//json parsing 
struct getdata : Codable{
    let data:[Data]
}
struct Data: Codable {
    let title: String
    let description: String
    let address: String
    let latitude: String
    let longitude: String
    let image: Image
}
struct Image: Codable {
    let small: String
}
