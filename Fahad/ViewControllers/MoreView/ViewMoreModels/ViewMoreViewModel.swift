//
//  ViewMoreViewModel.swift
//  Fahad
//
//  Created by Kondalu on 24/09/21.
//

import Foundation
import UIKit
import Alamofire
class ViewMoreDataResponce: UIViewController {
    
    static let shared = ViewMoreDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(ViewMoreDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(ViewMoreDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
