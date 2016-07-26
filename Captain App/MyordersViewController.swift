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
    var array = [-1]

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getOrders()
        
        if array.contains(1) {
            print("We've got apples!")
        } else {
            print("No apples here – sorry!")
        }
       let r=["a":"b","b":"c"]
        var a = ["x":r, "y":"d"]


        var error : NSError?
        
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(a, options: NSJSONWritingOptions.PrettyPrinted)
        
        let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
        
        print("masnfasd",jsonString)
        
        

        
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
        
        if array.contains(section){
          return  (arrayResponse.objectAtIndex(section).valueForKey("items")?.count)!
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Reuse", forIndexPath: indexPath) as! ItemsCell

        
        return cell
    }
    
    
    
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("cell") as! OrdersCell
        headerCell.btnUpdate!.addTarget(self, action:#selector(self.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        headerCell.btnUpdate?.tag=section;
        
        return headerCell
    }
   
    
    func buttonClicked(sender:UIButton)  {
        
        if array.contains(sender.tag){
            array.removeObjectsInArray([sender.tag])
            var indexPathArray = [NSIndexPath]()
            
            let count=arrayResponse.objectAtIndex(sender.tag).valueForKey("items")?.count
            for var i = 0; i < count; ++i {
                let indexPath = NSIndexPath(forRow: i, inSection: sender.tag)
                indexPathArray.append(indexPath)
                
            }
            
            self.tblData.deleteRowsAtIndexPaths(indexPathArray, withRowAnimation: UITableViewRowAnimation.Top)
        }
        else
        {
            array.append(sender.tag)
            var indexPathArray = [NSIndexPath]()
            
            let count=arrayResponse.objectAtIndex(sender.tag).valueForKey("items")?.count
            for var i = 0; i < count; ++i {
                let indexPath = NSIndexPath(forRow: i, inSection: sender.tag)
                indexPathArray.append(indexPath)
                
            }
            
            
            self.tblData.insertRowsAtIndexPaths(indexPathArray, withRowAnimation: UITableViewRowAnimation.Top)
        }
        
        
        
        
        
        
        
        //        ServerRequestController.sharedInstance.postRequestWithUrl([ "waiter_id":waiterID, "app_id":"446"], headers: [:], subUrl: GETORDER) { (response : NSDictionary?, error : NSError?) -> Void in
        //                            if ((error) != nil) {
        //                                print("Error logging you in!")
        //                                Datamodel.sharedInstance.hidehud(self.view)
        //
        //                            } else {
        //                                print("order response",response)
        //                                Datamodel.sharedInstance.hidehud(self.view)
        //                            }
        //                        }
        
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

extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}
