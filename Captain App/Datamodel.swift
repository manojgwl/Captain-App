//
//  Datamodel.swift
//  shukavana
//
//  Created by Shabeer on 14/01/16.
//  Copyright © 2016 sgsraga. All rights reserved.
//

import UIKit

private let sharedDelegate = Datamodel()

class Datamodel: NSObject {
    
    class var sharedInstance: Datamodel {
        return sharedDelegate
    }
    
    func showhud(hudview : UIView){
        
        let loadingNotification = MBProgressHUD.showHUDAddedTo(hudview, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.label.text = "Loading"
        hudview.addSubview(loadingNotification)
        
    }
    
 func hidehud(hudview : UIView){
    
    MBProgressHUD.hideHUDForView(hudview, animated: true)

    
    }
    
    
    
}
