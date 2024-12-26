//
//  OrderListModel.swift
//  Fahad
//
//  Created by Kondalu on 27/09/21.
//

import Foundation

struct OrderListResponseData : Codable {
   // let productImage : String?
    let orderNo : String?
    let orderId : String?
    let orderTotal : String?
    let productName : String?
    let productImage : String?
   }
struct OrderListDataStruct : Codable {
        let responseCode : Int?
        let responseText : String?
        let responseData : [OrderListResponseData]?
}

