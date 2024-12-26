//
//  MyAddressModel.swift
//  Fahad
//
//  Created by Kondalu on 13/09/21.
//

import Foundation
struct MyAdressResponseData : Codable {
    let addressId : String?
    let firstname : String?
    let lastname : String?
    let company : String?
    let address1 : String?
    let address2 : String?
    let postcode : String?
    let city : String?
    let zoneId : String?
    let zone : String?
    let phone : String?
    let countryId : String?
    let country : String?
    let strAddress : String?
    let defaultAddress : Int?
}
struct MyAddressDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [MyAdressResponseData]?
}
