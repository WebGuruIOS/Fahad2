//
//  OrderDetailsModel.swift
//  Fahad
//
//  Created by Kondalu on 15/09/21.
//

import Foundation
struct Amount : Codable {
    let title : String?
    let amount : String?
}
struct History : Codable {
    let status_id : String?
    let status_name : String?
    let date : String?
}
struct PaymentAddress : Codable {
    let firstName : String?
    let lastName : String?
    let company : String?
    let address : String?
    let city : String?
    let postCode : String?
    let country : String?
    let state : String?
    let address1 : String?
    let address2 : String?
    let phone : String?
}
struct PrdOption : Codable {
    let name : String?
    let value : String?
    let type : String?
}
struct Product : Codable {
    let productOrderId : String?
    let productId : String?
    let name : String?
    let details : String?
    let prdOption : [PrdOption]?
    let model : String?
    let productImage : String?
    let quantity : String?
    let price : String?
    let total : String?
    let isReview : String?
    let rating : Int?
}
struct OrderDetailsResponseData : Codable {
    let orderNo : String?
    let orderDate : String?
    let paymentMethod : String?
    let shippingMethod : String?
    let shippingAddress : ShippingAddress?
    let paymentAddress : PaymentAddress?
    let product : [Product]?
    let amount : [Amount]?
    let history : [History]?
    let statusName : String?
    let taxAmount : String?
    let subTotal : String?
    let shippingTotal : String?
    let couponTotal : String?
    let finalTotal : String?
}
struct ShippingAddress : Codable {
    let firstName : String?
    let lastName : String?
    let company : String?
    let address : String?
    let city : String?
    let postCode : String?
    let country : String?
    let state : String?
    let address1 : String?
    let address2 : String?
    let phone : String?
}
struct OrderDetailDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : OrderDetailsResponseData?
}
