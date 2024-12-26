//
//  ProductDetailModel.swift
//  Fahad
//
//  Created by Kondalu on 15/09/21.
//

import Foundation
struct ImageGallery : Codable {
    let thumb : String?
}
struct ProductOptions : Codable {
    let productOptionId : String?
    let productOptionValue : [ProductOptionValue]?
    let optionId : String?
    let name : String?
    let type : String?
    let value : String?
    let required : String?
}
struct ProductOptionValue : Codable {
    let productOptionValueId : String?
    let optionValueId : String?
    let name : String?
    let price : String?
    let pricePrefix : String?
}
struct ProductRelated : Codable {
    let productId : String?
    let thumb : String?
    let name : String?
    let categoryId : String?
    let categoryName : String?
    let description : String?
    let price : String?
    let special : String?
    let tax : String?
    let rating : String?
    let minimum : String?
    let stockStatusId : String?
    let stockStatus : String?
    let optionCount : String?
    let isWishlist : String?
}
struct ProductReviews : Codable {
    let reviewId : String?
    let author : String?
    let text : String?
    let rating : String?
}
struct ProductDetailsResponseData : Codable {
    let productId : String?
    let thumb : String?
    let name : String?
    let shareLink : String?
    let categoryId : String?
    let categoryName : String?
    let description : String?
    let mainPrice : String?
    let price : String?
    let special : String?
    let tax : String?
    let productSaleOff : String?
    let rating : String?
    let minimum : String?
    let manufacturer : String?
    let model : String?
    let sku : String?
    let ean : String?
    let upc : String?
    let jan : String?
    let isbn : String?
    let mpn : String?
    let reward : String?
    let points : String?
    let stockInfo : String?
    let imageGallery : [ImageGallery]?
   // let productDiscount : [String]?
    let productOptions : [ProductOptions]?
    let weight : String?
    let weightName : String?
    let length : String?
    let width : String?
    let height : String?
    let productReviews : [ProductReviews]?
    let productRelated : [ProductRelated]?
    let isWishlist : String?
    let isPurchase : String?
    let seller_id : String?
    let sellerName : String?
    let sellerPhone : String?
    let sellerReviews : String?
    let sellerRating : String?
    let hasReview : String?
    let serrlerProucts : [SerrlerProucts]?
    let cartCount : String?
    let reviwCount : String?
}
struct SerrlerProucts : Codable {
    let product_id : String?
    let seller_id : String?
    let thumb : String?
    let name : String?
    let price : String?
    let special : String?
    let rating : String?
    let reviews : String?
}
struct ProductDetalsDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : ProductDetailsResponseData?
}
