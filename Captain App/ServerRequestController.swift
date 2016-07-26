//
//  ServerRequestController.swift
//  SGSPostAdmin
//
//  Created by Shabeer on 22/07/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

import UIKit
import Alamofire

typealias ServiceResponse = (NSDictionary?, NSError?) -> Void

class ServerRequestController: NSObject {
    
    
   
    var baseUrl = "http://apps.goodworklabs.com/customer"
    
    
    class var sharedInstance : ServerRequestController {
        struct Singleton {
            static let instance = ServerRequestController()
        }
        return Singleton.instance
    }
    
    
    
    // Post Request
    
    func postRequestWithUrl( parameters : [String : AnyObject], headers : [String : String], subUrl : String, onCompletion :ServiceResponse ) -> Void {
        
        
//        http://apps.goodworklabs.com/customer/getordersforwaiter
//        Input parameters: waiter_id, app_id (static "446")

        
        //sabir
        print("parameters",parameters)
        print("url",baseUrl+subUrl)
        
        Alamofire.request(.POST, baseUrl+subUrl, parameters: parameters , encoding: .JSON, headers: headers).responseJSON { responseObject in switch responseObject.result {
            
        case .Success(let jsonObject) :
            onCompletion(jsonObject as? NSDictionary, nil)
            break
        case .Failure(let error) :
            onCompletion(nil, error)
            break
            }
        }
    }
    
    func postRequestform( parameters : [String : AnyObject], headers : [String : String], subUrl : String, onCompletion :ServiceResponse ) -> Void {
        
        
        Alamofire.request(.POST, "http://apps.goodworklabs.com/customer/getordersforwaiter", parameters: ["waiter_id": "56","app_id":"446"])
            .responseJSON { responseObject in switch responseObject.result {
                
            case .Success(let jsonObject) :
                
                onCompletion(jsonObject as? NSDictionary, nil)

                break
            case .Failure(let error) :
                
                onCompletion(nil, error)

                break
                
                }
        }
        
        
        //        http://apps.goodworklabs.com/customer/getordersforwaiter
        //        Input parameters: waiter_id, app_id (static "446")
        
        
        //sabir
        print("parameters",parameters)
        print("url",baseUrl+subUrl)
        
//        Alamofire.request(.POST, baseUrl+subUrl, parameters: parameters , encoding: .JSON, headers: headers).responseJSON { responseObject in switch responseObject.result {
//            
//        case .Success(let jsonObject) :
//            break
//        case .Failure(let error) :
//            break
//            }
//        }
    }
    
    
    
    // Get Request
    

    func getRequestWithUrl( parameters : [String : AnyObject], headers : [String : String], subUrl : String, onCompletion :ServiceResponse ) -> Void {
        
        
        //sabir
        print("parameters",parameters)
        print("parameters",baseUrl+subUrl)
        
        Alamofire.request(.POST, baseUrl+subUrl, parameters: parameters , encoding: .JSON, headers: headers).responseJSON { responseObject in switch responseObject.result {
            
        case .Success(let jsonObject) :
            onCompletion(jsonObject as? NSDictionary, nil)
            break
        case .Failure(let error) :
            onCompletion(nil, error)
            break
            }
        }
    }
    
    
    
    
}
