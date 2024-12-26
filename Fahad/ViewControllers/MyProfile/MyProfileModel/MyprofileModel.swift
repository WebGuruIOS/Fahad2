//
//  MyprofileModel.swift
//  Fahad
//
//  Created by Kondalu on 13/09/21.
//

import Foundation
struct MyAccountResponseData : Codable {
    let customerId : String?
    let firstName : String?
    let lastName : String?
    let email : String?
    let profileImage : String?
    let telephone : String?
    let flatNo : String?
    let addressLine1 : String?
    let addressLine2 : String?
    let landMark : String?
    let pincode : String?
}
struct MyAccountDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : MyAccountResponseData?
}
