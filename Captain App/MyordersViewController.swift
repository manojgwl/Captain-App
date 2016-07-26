//
//  MyordersViewController.swift
//  Captain App
//
//  Created by manojkumar Jonna on 25/07/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

import UIKit
import Alamofire


class MyordersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblData: UITableView!
    
    var waiterID: String!
    var arrayResponse:NSMutableArray!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getOrders()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  UITableViewDelegate Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return arrayResponse.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! OrdersCell
        cell.lblOrder?.text="mmam"

        
        return cell
    }
    
    
    
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("cell") as! OrdersCell
        headerCell.btnUpdate!.addTarget(self, action:#selector(self.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        headerCell.btnUpdate?.tag=section;
        
        return headerCell
    }
   
    
    func buttonClicked(sender:UIButton)  {
        print(sender.tag)
    }
    
    // MARK:  api callas
    
    func  getOrders()   {
        
        let waiterID = Utility.getWaiterID()
        print("value",waiterID)
        
        if(Utility.isConnectionAvailableWithAlert(true, currentClass: self)){
            Datamodel.sharedInstance.showhud(self.view)
            
            Alamofire.request(.POST, "http://apps.goodworklabs.com/customer/getordersforwaiter", parameters: ["waiter_id":waiterID,"app_id":"446"])
                .responseJSON { response in switch response.result {
                case .Success(let JSON):
                    print("Success with JSON: \(JSON)")
                    Datamodel.sharedInstance.hidehud(self.view)
                    
                    let response = JSON as! NSDictionary
                    
                    if(response.valueForKey("status")as! NSString == "1"){
                self.arrayResponse=response.valueForKey("records") as! NSMutableArray
                    
                    print(self.arrayResponse!)
                    
                    self.tblData.delegate = self
                    self.tblData.dataSource = self
                        self.tblData.reloadData()}
                    
                    
                    
                case .Failure(let error):
                    Datamodel.sharedInstance.hidehud(self.view)
                    
                    print("Request failed with error: \(error)")
                    }
            }
            
            
            
            
            
            
            
            //            ServerRequestController.sharedInstance.postRequestWithUrl([ "waiter_id":waiterID, "app_id":"446"], headers: [:], subUrl: GETORDER) { (response : NSDictionary?, error : NSError?) -> Void in
            //                if ((error) != nil) {
            //                    print("Error logging you in!")
            //                    Datamodel.sharedInstance.hidehud(self.view)
            //
            //                } else {
            //                    print("order response",response)
            //                    Datamodel.sharedInstance.hidehud(self.view)
            //                }
            //            }
        }
        
        
    }
    
    
    func logout()  {
        
        let waiterID = Utility.getWaiterID()
        print("value",waiterID)
        
        if(Utility.isConnectionAvailableWithAlert(true, currentClass: self)){
            Datamodel.sharedInstance.showhud(self.view)
            
            ServerRequestController.sharedInstance.postRequestWithUrl([ "waiter_id": waiterID], headers: [:], subUrl: LOGOUT) { (response : NSDictionary?, error : NSError?) -> Void in
                if ((error) != nil) {
                    
                    print("Error logout  ")
                    Datamodel.sharedInstance.hidehud(self.view)
                    
                } else {
                    print("logout",response)
                    
                    Datamodel.sharedInstance.hidehud(self.view)
                }
            }
        }
    }
    
    
    func deleteOrder(orderID:String)  {
        
        
        if(Utility.isConnectionAvailableWithAlert(true, currentClass: self)){
            Datamodel.sharedInstance.showhud(self.view)
            
            ServerRequestController.sharedInstance.postRequestWithUrl([ "order_id": orderID], headers: [:], subUrl: DELETEORDER) { (response : NSDictionary?, error : NSError?) -> Void in
                if ((error) != nil) {
                    
                    print("Error order  ")
                    Datamodel.sharedInstance.hidehud(self.view)
                    
                } else {
                    print("orderdelte",response)
                    
                    Datamodel.sharedInstance.hidehud(self.view)
                }
            }
        }
        
    }
    
    
    
    
    
    

    

}
