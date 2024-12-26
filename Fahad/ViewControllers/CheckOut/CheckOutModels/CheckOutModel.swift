//
//  CheckOutModel.swift
//  Fahad
//
//  Created by Kondalu on 29/09/21.
//

import Foundation
struct CheckOutCart : Codable {
    let cartId : String?
    let productId : String?
    let thumb : String?
    let name : String?
    let model : String?
    let option : [CheckOutOption]?
    let quantity : String?
    let orginalPrice : String?
    let price : String?
    let total : String?
    let prdTotal : String?
}
struct CheckOutOption : Codable {
    let product_option_id : String?
    let product_option_value_id : String?
    let option_id : String?
    let option_value_id : String?
    let name : String?
    let value : String?
    let type : String?
    let quantity : String?
    let subtract : String?
    let price : String?
    let price_prefix : String?
    let points : String?
    let points_prefix : String?
    let weight : String?
    let weight_prefix : String?
}
struct CheckoutResponseData : Codable {
    let cart : [CheckOutCart]?
    let responseExtraData : CheckoutResponseExtraData?
}
struct CheckoutResponseExtraData : Codable {
    let orginal_cost_total : String?
    let cart_total : String?
    let tax_total : String?
    let coupon_total : String?
    let shipping_total : [CheckoutShipping_total]?
}
struct CheckoutShipping_total : Codable {
    let code : String?
    let title : String?
    let cost : String?
    let taxClassId : String?
    let text : String?
}
struct CheckoutDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : CheckoutResponseData?
}
