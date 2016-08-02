//
//  ViewController.swift
//  Captain App
//
//  Created by Shabeer on 25/07/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController,UITextFieldDelegate {
     
    @IBOutlet var txtWaiterid: UITextField!
    var currentFrame:CGRect!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="RESTAURANT CAPTAIN"
        currentFrame=self.view.bounds
        
        self.txtWaiterid.delegate = self
        
        let placeholder = NSAttributedString(string: "Waiter ID", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        
        self.txtWaiterid.attributedPlaceholder = placeholder;

       // self.navigationController?.navigationBar.hidden=true
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
                
                ServerRequestController.sharedInstance.postRequestWithUrl([ "waiter_id": (self.txtWaiterid?.text)!, "device_token": Utility.getDeviceToken(),"device_type":"ios"], headers: [:], subUrl: "/login") { (response : NSDictionary?, error : NSError?) -> Void in
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
                            self.textFieldShouldReturn(self.txtWaiterid)
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.view.frame=CGRectMake(self.currentFrame.origin.x, self.currentFrame.origin.y, self.currentFrame.size.width, self.currentFrame.size.height)
        })
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.view.frame=CGRectMake(self.currentFrame.origin.x, self.currentFrame.origin.y-50, self.currentFrame.size.width, self.currentFrame.size.height)
        })

    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.view.frame=CGRectMake(self.currentFrame.origin.x, self.currentFrame.origin.y, self.currentFrame.size.width, self.currentFrame.size.height)
        })
        return true
    }


}

