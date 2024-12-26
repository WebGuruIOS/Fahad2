//
//  OrderListViewModel.swift
//  Fahad
//
//  Created by Kondalu on 27/09/21.
//


import Foundation
import UIKit
import Alamofire
class OrderListDataResponce1: UIViewController {
    
    static let shared = OrderListDataResponce1()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(OrderListDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(OrderListDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                ApiService.shared.showAlert(title: "", msg: "No orders Found" )
                print("Error on parsing")
            }
        }
    }
    
}
