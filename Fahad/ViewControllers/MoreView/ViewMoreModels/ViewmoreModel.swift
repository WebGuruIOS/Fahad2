//
//  ViewmoreModel.swift
//  Fahad
//
//  Created by Kondalu on 24/09/21.
//

import Foundation
struct ViewMoreResponseData : Codable {
    let page_id : String?
    let page_title : String?
    let page_description : String?
    let page_url : String?
}
struct ViewMoreDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : ViewMoreResponseData?
}
