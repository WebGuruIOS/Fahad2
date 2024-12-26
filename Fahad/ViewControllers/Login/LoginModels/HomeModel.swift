//
//  HomeModel.swift
//  Fahad
//
//  Created by Kondalu on 02/09/21.
//

import Foundation
struct BannerSlider : Codable {
    let bannerId : String?
    let title : String?
    let image : String?
}
struct Best_seller : Codable {
    let productId : String?
    let thumb : String?
    let name : String?
    let description : String?
    let price : String?
    let special : String?
    let tax : String?
    let rating : String?
    let categoryId : String?
    let minimum : String?
    let isWishlist : String?
}
struct Categories : Codable {
    let categoryId : String?
    let thumb : String?
    let name : String?
    let description : String?
}
struct ElectronicBanner : Codable {
    let bannerId : String?
    let title : String?
    let image : String?
}
struct FashionBanner : Codable {
    let bannerId : String?
    let title : String?
    let image : String?
}
struct Featured_product : Codable {
    let productId : String?
    let seller_id : String?
    let thumb : String?
    let name : String?
    let description : String?
    let price : String?
    let special : String?
    let tax : String?
    let rating : String?
    let discount : String?
    let minimum : String?
    let isWishlist : String?
}
struct Featured_seller : Codable {
    let bannerId : String?
    let title : String?
    let image : String?
}
struct Home_appliances : Codable {
    let productId : String?
    let thumb : String?
    let name : String?
    let description : String?
    let price : String?
    let special : String?
    let tax : String?
    let minimum : String?
    let rating : String?
    let stockStatusId : String?
    let stockStatus : String?
    let optionCount : String?
    let isWishlist : String?
}
struct New_product : Codable {
    let productId : String?
    let thumb : String?
    let name : String?
    let description : String?
    let price : String?
    let special : String?
    let tax : String?
    let rating : String?
    let href : String?
    let categoryName : String?
    let discount : String?
    let minimum : String?
    let isWishlist : String?
}
struct ResponseData : Codable {
    let bannerSlider : [BannerSlider]?
    let electronicBanner : [ElectronicBanner]?
    let fashionBanner : [FashionBanner]?
    let videoBanner : [VideoBanner]?
    let featured_seller : [Featured_seller]?
    let shop_by_category : Shop_by_category?
    let featured_product : [Featured_product]?
    let trending_product : [Trending_product]?
    let new_product : [New_product]?
    let best_seller : [Best_seller]?
    let home_appliances : [Home_appliances]?
    let mobile : [String]?
}
struct Shop_by_category : Codable {
    let categories : [Categories]?
}
struct Trending_product : Codable {
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
    let isWishlist : String?
}
struct VideoBanner : Codable {
    let bannerId : String?
    let title : String?
    let image : String?
}
struct HomeDataStruct : Codable {
    let responseCode : Int?
    let responseText : String?
    let responseData : ResponseData?
}               
