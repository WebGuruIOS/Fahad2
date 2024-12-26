//
//  CountryModel.swift
//  Fahad
//
//  Created by Kondalu on 29/09/21.
//

import Foundation
struct CountryResponseData : Codable {
    let id : String?
    let name : String?
}
struct CountryDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [CountryResponseData]?
}
