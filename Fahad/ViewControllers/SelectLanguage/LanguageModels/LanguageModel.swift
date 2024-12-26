//
//  LanguageModel.swift
//  Fahad
//
//  Created by Kondalu on 25/09/21.
//

import Foundation
struct LanguageResponseData : Codable {
    let id : String?
    let name : String?
    let code : String?
    let locale : String?
}
struct LanguageDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : [LanguageResponseData]?
}
