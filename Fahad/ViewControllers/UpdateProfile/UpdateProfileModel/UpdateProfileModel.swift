//
//  UpdateProfileModel.swift
//  Fahad
//
//  Created by Kondalu on 13/09/21.
//

import Foundation
struct UpdateProfileResponseData : Codable {
    let id : String?
    let firstName : String?
    let lastName : String?
    let email : String?
    let profileImage : String?
    let telephone : String?
    let addressLine1 : String?
    let addressLine2 : String?
    let pincode : String?
}
struct UpdateProfileDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : ResponseData?
}
