//
//  RemoveAndAddWishlistViewModel.swift
//  Fahad
//
//  Created by Kondalu on 17/09/21.
//

import Foundation
import UIKit
import Alamofire
class RemoveAndAddWishListDataResponce: UIViewController {
    
    static let shared = RemoveAndAddWishListDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(RemoveAndAddDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(RemoveAndAddDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}

