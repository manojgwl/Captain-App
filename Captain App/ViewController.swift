//
//  ViewController.swift
//  Captain App
//
//  Created by Shabeer on 25/07/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     
    @IBOutlet weak var txtWaiterid: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden=true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden=false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionOnLogin(sender: UIButton) {
        
        
        if let text = self.txtWaiterid!.text where !text.isEmpty {
            
            if(Utility.isConnectionAvailableWithAlert(true, currentClass: self)){
                Datamodel.sharedInstance.showhud(self.view)
                
                ServerRequestController.sharedInstance.postRequestWithUrl([ "waiter_id": (self.txtWaiterid?.text)!, "device_token": Utility.getDeviceToken()], headers: [:], subUrl: "/login") { (response : NSDictionary?, error : NSError?) -> Void in
                    if ((error) != nil) {
                        
                        print("Error logging you in!")
                        Datamodel.sharedInstance.hidehud(self.view)
                        
                    } else {
                        print("Do something in the view controller in response to successful login!",response)
                        
                        Datamodel.sharedInstance.hidehud(self.view)
                        if(response?.valueForKey("status")as! NSString == "1"){
                            Utility.storeWaiterID((self.txtWaiterid?.text)!)
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewControllerWithIdentifier("MyordersViewController")
                            
                            // Alternative way to present the new view controller
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
        else{
            
            Utility.showAlert(VALIDATE_WAITERID,currentClass: self)
        }
        
    }
}

