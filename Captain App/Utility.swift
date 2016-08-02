//
//  Utility.swift
//  shukavana
//
//  Created by Shabeer on 20/06/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

import UIKit


class Utility: NSObject {
    
    
    class func setNavTabColour()->UIColor {
        return UIColor(red: 252/256, green: 95/256, blue: 66/256, alpha: 1.0)
    }
    
    class func baseUrl(urlString : String)->String {
        return "http://d2x3zo6le2eu8k.cloudfront.net/" + urlString
    }
    
    
    class func navigationtite(navigationbar:UINavigationItem, target : AnyObject,title:NSString)  {
        
        
        
        let Cview = UIView(frame: CGRectMake(0, 0, 120, 44))
        Cview.backgroundColor = UIColor.clearColor()
        let LbarButtonItem = UIBarButtonItem(customView: Cview)
        
        
        
        let LappFrame = CGRect(x: 0, y: 0, width: 120, height: 44)
        
        let  Applabel = UILabel(frame: LappFrame)
        Applabel.text = title as String
        Applabel.textColor=Utility.hexStringToUIColor("#c2863d")
        Applabel.font = UIFont(name: "Avenir Book", size: 17.0)
        
        Cview.addSubview(Applabel)
        
        
        
        let view = UIView(frame: CGRectMake(0, 0, 130, 44))
        view.backgroundColor = UIColor.clearColor()
        let barButtonItem = UIBarButtonItem(customView: view)
        
        
        let appFrame = CGRect(x: 10, y: 0, width: 80, height: 44)
        
        let  locLabel = UILabel(frame: appFrame)
        locLabel.text = "Bangalore"
        locLabel.textColor=Utility.hexStringToUIColor("#c2863d")
        locLabel.font = UIFont(name: "Avenir Book", size: 14.0)
        
        view.addSubview(locLabel)
        
        
        
        let locImFrame = CGRect(x:  locLabel.frame.origin.x+locLabel.frame.width, y: 15, width: 10, height: 15)
        
        
        let imgLocation = UIImageView(frame: locImFrame)
        
        imgLocation.image = UIImage(named: "Marker_Filled_100")
        
        view.addSubview(imgLocation)
        
        
        let cartImFrame = CGRect(x: imgLocation.frame.origin.x+imgLocation.frame.width+10, y: 15, width: 20, height: 15)
        
        let btnCart = UIButton(frame: cartImFrame)
        
        btnCart.setImage(UIImage(named: "Shopping_Cart_Filled_100"), forState: UIControlState.Normal)
        
        view.addSubview(btnCart)
        
        
        navigationbar.rightBarButtonItem = barButtonItem
        
        navigationbar.leftBarButtonItem = LbarButtonItem
        
        
    }

   
    
  class  func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
  
    class func isConnectionAvailableWithAlert(showAlert : Bool, currentClass : AnyObject)->Bool {
        
        let checkConnection = CheckConnection()
        if showAlert{
            checkConnection.startWithCurrentClass(currentClass)
        }
        return checkConnection.checkIntenetRechable()
    }
    
    class func checkingForNull( givenString : String) ->String {
        if (givenString.isEmpty) {
            
            
            print("String is nil or empty")
            return "Not Available";
        }else{
            return givenString
        }
        
        
    }
    
    class func showAlert( givenString : String, currentClass : AnyObject)  {
        
        let alert=UIAlertController(title:APPLICATION_NAME, message:givenString , preferredStyle: UIAlertControllerStyle.Alert);
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil));

        currentClass.presentViewController(alert, animated: true, completion: nil);
        
    
    
    }
    
    class func storeWaiterID(waiterID:String)
    {
        NSUserDefaults.standardUserDefaults().setObject(waiterID, forKey: "waiter_ID")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    class func getWaiterID()->String
    {
        if let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("waiter_ID") as? String {
            return returnValue
        }
        
        return "0"
    }
    
    class func storeDeviceToken(deviceToken:String)
    {
        NSUserDefaults.standardUserDefaults().setObject(deviceToken, forKey: "deviceToken")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    class func getDeviceToken()->String
    {
        if let returnValue = NSUserDefaults.standardUserDefaults().objectForKey("deviceToken") as? String {
            return returnValue
        }
        
        return "0"
    }
    
    
}
