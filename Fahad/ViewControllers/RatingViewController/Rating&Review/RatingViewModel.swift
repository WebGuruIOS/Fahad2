//
//  RatingViewModel.swift
//  Fahad
//
//  Created by Arun Kr Chaudhary on 16/03/22.
//

import Foundation
import UIKit
import Alamofire

class RatingReviewDataResponce: UIViewController {
    static let shared = RatingReviewDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(RatingReviewStruct?)->Void){
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(RatingReviewStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
     
          }
       }
    }
}
/*
 static let shared = ChangePasswordDataResponce()
 public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(ChangePasswordStruct?)->Void)  {
     ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
         guard let data = data else { return }
         do{
             let res = try JSONDecoder().decode(ChangePasswordStruct.self, from: data)
             completion(res)
         }catch{
             completion(nil)
             print("Error on parsing")
         }
     }
 }
 */
