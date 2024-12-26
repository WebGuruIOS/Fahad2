//
//  SubCateModel.swift
//  Sumatra
//
//  Created by Kondalu on 12/07/21.
//  Copyright © 2021 wbg. All rights reserved.
//

import Foundation
struct CategoryListing2: Codable {
    let responseData: [CategoryListingData]
}
struct CategoryListingData: Codable {
    let id, title: String
    let subCategory: [SubCategoryData]
}
struct SubCategoryData: Codable {
    let id, title: String
}
