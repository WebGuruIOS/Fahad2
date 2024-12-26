//
//  sortModel.swift
//  Fahad
//
//  Created by Kondalu on 24/09/21.
//

import Foundation
struct SortResponseData : Codable {
    let productId : String?
    let thumb : String?
    let name : String?
    let description : String?
    let price : String?
    let special : String?
    let tax : String?
    let rating : String?
    let discount : String?
    let minimum : String?
    let seller_id : String?
    let isWishlist : String?
}
struct SortDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [SortResponseData]?
}
