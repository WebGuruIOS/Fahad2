//
//  CheckOutViewModel.swift
//  Fahad
//
//  Created by Kondalu on 29/09/21.
//

import Foundation
import UIKit
import Alamofire
class CheckoutDataResponce: UIViewController {
    
    static let shared = CheckoutDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(CheckoutDataStruct?)->Void)  {
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(CheckoutDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
