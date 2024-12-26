//
//  SearchModel.swift
//  Fahad
//
//  Created by Kondalu on 28/09/21.
//

import Foundation
struct SearchResponseData : Codable {
    let product_id : String?
    let thumb : String?
    let name : String?
    let description : String?
    let price : String?
    let special : String?
    let tax : String?
    let rating : String?
    let minimum : String?
    let stock_status_id : String?
    let stock_status : String?
    let option_count : Int?
    let is_wishlist : String?
}
struct ProductSearchDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [SearchResponseData]?
}
