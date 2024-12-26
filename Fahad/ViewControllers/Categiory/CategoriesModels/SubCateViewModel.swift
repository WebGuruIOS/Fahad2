//
//  SubCateViewModel.swift
//  Sumatra
//
//  Created by Kondalu on 12/07/21.
//  Copyright © 2021 wbg. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class subCateDataResponce: UIViewController {
    
    static let shared = subCateDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(CategoryListing2?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(CategoryListing2.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}


