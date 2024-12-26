//
//  ProductDetailViewModel.swift
//  Fahad
//
//  Created by Kondalu on 15/09/21.
//

import Foundation
import UIKit
import Alamofire
class ProductDetailsDataResponce: UIViewController {
    
    static let shared = ProductDetailsDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(ProductDetalsDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(ProductDetalsDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
