//
//  WishlistViewModel.swift
//  Fahad
//
//  Created by Kondalu on 13/09/21.
//

import Foundation
import UIKit
import Alamofire
class WishListDataResponce: UIViewController {
    
    static let shared = WishListDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(WishListDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(WishListDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}

