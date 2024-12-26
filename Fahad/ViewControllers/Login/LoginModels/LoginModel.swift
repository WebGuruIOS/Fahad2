//
//  LoginModel.swift
//  Fahad
//
//  Created by Kondalu on 02/09/21.
//


import Foundation
struct LoginResponseData : Codable {
    let id : String?
    let firstName : String?
    let lastName : String?
    let email : String?
    let telephone : String?
    let profileImage : String?
}
struct LoginDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : LoginResponseData?
}
