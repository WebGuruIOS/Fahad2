//
//  MyCartModel.swift
//  Fahad
//
//  Created by Kondalu on 20/09/21.
//

import Foundation
struct Option : Codable {
    let name : String?
    let value : String?
    let type : String?
}
struct MyCartResponseData : Codable {
    let cartId : String?
    let productId : String?
    let thumb : String?
    let name : String?
    let model : String?
    let option : [Option]?
    let quantity : String?
    let orginalPrice : String?
    let price : String?
    let total : String?
    let prdTotal : String?
}
struct ResponseExtraData : Codable {
    let orginal_cost_total : String?
    let cart_total : String?
    let tax_total : String?
    let shipping_total : [Shipping_total]?
}
struct Shipping_total : Codable {
    let code : String?
    let title : String?
    let cost : String?
    let taxClassId : String?
    let text : String?
}
struct MyCartDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [MyCartResponseData]?
    let responseExtraData : ResponseExtraData?
}
