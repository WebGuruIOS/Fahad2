//
//  OrderDetailsViewModel.swift
//  Fahad
//
//  Created by Kondalu on 15/09/21.
//


import Foundation
import UIKit
import Alamofire
class OrderDetailsDataResponce: UIViewController {
    
    static let shared = OrderDetailsDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(OrderDetailDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(OrderDetailDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}