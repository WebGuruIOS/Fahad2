//
//  WishlistModel.swift
//  Fahad
//
//  Created by Kondalu on 13/09/21.
//

import Foundation
struct WishlistResponseData : Codable {
    let productId : String?
    let thumb : String?
    let name : String?
    let description : String?
    let price : String?
    let special : String?
    let tax : String?
    let rating : String?
    let minimum : String?
    let hasOption : String?
    let product_model : String?
    let product_weight : String?
    let product_weight_type : String?
}
struct WishListDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [WishlistResponseData]?
}
