//
//  AddToCartViewModel.swift
//  Fahad
//
//  Created by Kondalu on 20/09/21.
//

import Foundation
import UIKit
import Alamofire
class AddToCartDataResponce: UIViewController {
    
    static let shared = AddToCartDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(AddToCartDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(AddToCartDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}


