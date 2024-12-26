//
//  Rating&ReviewModel.swift
//  Fahad
//
//  Created by Arun Kr Chaudhary on 16/03/22.
//

import Foundation
struct RatingReviewStruct: Codable {
    let responseCode: Int?
    let responseText: String?
    let reviewData : [responseData]?
}

struct responseData: Codable {
    
  let review_id : String?
  let product_id : String?
  let customer_id : String?
  let author : String?
  let text : String?
  let rating : String?
  let status : String?
  let date_added : String?
  let date_modified : String?
  let seller_id : String?
}


