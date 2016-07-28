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
    var arrayResponse:NSMutableArray=NSMutableArray()
    var array = [-1]

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton=true
        self.getOrders()
        self.title="My orders"
        

        
       
        let logout = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(logoutTapped))
        let coloor = Utility.hexStringToUIColor("#C9B059")
        
        if let font = UIFont (name: "Merriweather", size: 20) {
            //UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font,NSForegroundColorAttributeName: UIColor.whiteColor()]
            
            logout.setTitleTextAttributes([NSFontAttributeName: font,NSForegroundColorAttributeName:coloor], forState: .Normal)

            
        }

        
        navigationItem.rightBarButtonItems = [logout]
        

        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func logoutTapped()  {
        self.logout()    }
    
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
        return 75;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Reuse", forIndexPath: indexPath) as! ItemsCell
        cell.lblFoodName?.text=arrayResponse.objectAtIndex(indexPath.section).valueForKey("items")?.objectAtIndex(indexPath.row).valueForKey("FOOD_ITEM_NAME")as? String
        cell.lblcount?.text=arrayResponse.objectAtIndex(indexPath.section).valueForKey("items")?.objectAtIndex(indexPath.row).valueForKey("FOOD_QUANTITY")as? String
        
        cell.btnPlus!.addTarget(self, action:#selector(self.plusClicked(_:)), forControlEvents: .TouchUpInside)
        cell.btnPlus?.tag=indexPath.row;
        cell.btnPlus?.superview?.tag=indexPath.section
        
        cell.btnMinus?.tag=indexPath.row;
        cell.btnMinus?.superview?.tag=indexPath.section
        cell.lblorderType?.text=arrayResponse.objectAtIndex(indexPath.section).valueForKey("items")?.objectAtIndex(indexPath.row).valueForKey("FOOD_CATEGORY")as? String
        
        if(indexPath.row>0){
            if((arrayResponse.objectAtIndex(indexPath.section).valueForKey("items")?.objectAtIndex(indexPath.row-1).valueForKey("FOOD_CATEGORY")as? String) == (arrayResponse.objectAtIndex(indexPath.section).valueForKey("items")?.objectAtIndex(indexPath.row).valueForKey("FOOD_CATEGORY")as? String)){
                cell.lblorderType?.hidden=true
                
            }
            else{
                cell.lblorderType?.hidden=false
            }
        }
        else{
            cell.lblorderType?.hidden=false
            
        }
        

        
        cell.btnMinus!.addTarget(self, action:#selector(self.minusClicked(_:)), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("cell") as! OrdersCell
        headerCell.btnUpdate!.addTarget(self, action:#selector(self.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        headerCell.btnDelete!.addTarget(self, action:#selector(self.deleteClicked(_:)), forControlEvents: .TouchUpInside)
        headerCell.btnEDit!.addTarget(self, action:#selector(self.editClicked(_:)), forControlEvents: .TouchUpInside)
        headerCell.btnDelete?.tag=section
        headerCell.btnUpdate?.tag=section
        headerCell.btnEDit?.tag=section
        headerCell.contentView.backgroundColor=UIColor.whiteColor()
        
        let dateAsString = arrayResponse.objectAtIndex(section).valueForKey("ORDERS_TIME")as! String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.dateFromString(dateAsString)
        dateFormatter.dateFormat = "h:mm a"
        let date24 = dateFormatter.stringFromDate(date!)
        headerCell.lblTime?.text=date24 as String
        
        headerCell.lblTableNo?.text = String(format:"Table %@", arrayResponse.objectAtIndex(section).valueForKey("TABLE_ID")as! String)
        
        headerCell.lblOrder?.text=arrayResponse.objectAtIndex(section).valueForKey("CAPTAINAPP_STATUS")as? String
        return headerCell.contentView
    }
    
   
    func deleteClicked(sender:UIButton)  {
        self.deleteOrder(arrayResponse.objectAtIndex(sender.tag).valueForKey("ORDERS_ID")as! String)
    }
    func plusClicked(sender:UIButton)  {
        print(sender.tag)
        print(sender.superview!.tag)
        
        var dic:NSDictionary=NSDictionary()
        dic=arrayResponse.objectAtIndex(sender.superview!.tag).valueForKey("items")?.objectAtIndex(sender.tag) as! NSDictionary
        let foundationDictionary = NSMutableDictionary(dictionary: dic)
        print(foundationDictionary)
        
        let count=foundationDictionary.valueForKey("FOOD_QUANTITY") as! String
        var a:Int? = Int(count)
        a=a!+1;
        
        let value=String(format:"%d", a!)
        foundationDictionary.setValue(value, forKey: "FOOD_QUANTITY")
        var array:NSArray=NSArray()
        array=arrayResponse.objectAtIndex(sender.superview!.tag).valueForKey("items") as! NSArray
        let changedArray = NSMutableArray(array: array)
        
        changedArray[sender.tag]=foundationDictionary
        
        let position: CGPoint = sender.convertPoint(CGPointZero, toView: self.tblData)
        if let indexPath1 = self.tblData.indexPathForRowAtPoint(position)
        {
            let cell=self.tblData.cellForRowAtIndexPath(indexPath1) as! ItemsCell
            cell.lblcount?.text=String(format:"%d", a!)as String
            
        }
        var finalDic:NSDictionary=NSDictionary()
        finalDic=arrayResponse.objectAtIndex((sender.superview?.tag)!) as! NSDictionary
        let changedDic = NSMutableDictionary(dictionary: finalDic)
        changedDic.setValue(changedArray, forKey: "items")
        var array1:NSArray=NSArray()
        array1=self.arrayResponse as NSArray
        let replacedArray = NSMutableArray(array: array1)
        replacedArray[(sender.superview?.tag)!]=changedDic

        self.arrayResponse=replacedArray

        

        
    }
    func minusClicked(sender:UIButton) {
        
        var dic:NSDictionary=NSDictionary()
        dic=arrayResponse.objectAtIndex(sender.superview!.tag).valueForKey("items")?.objectAtIndex(sender.tag) as! NSDictionary
        let foundationDictionary = NSMutableDictionary(dictionary: dic)
        print(foundationDictionary)
        
        let count=foundationDictionary.valueForKey("FOOD_QUANTITY") as! String
        var a:Int? = Int(count)
        
        if(a>0){
            a=a!-1;
            
            let value=String(format:"%d", a!)
            foundationDictionary.setValue(value, forKey: "FOOD_QUANTITY")
            var array:NSArray=NSArray()
            array=arrayResponse.objectAtIndex(sender.superview!.tag).valueForKey("items") as! NSArray
            let changedArray = NSMutableArray(array: array)
            changedArray[sender.tag]=foundationDictionary
            let position: CGPoint = sender.convertPoint(CGPointZero, toView: self.tblData)
            if let indexPath1 = self.tblData.indexPathForRowAtPoint(position)
            {
                let cell=self.tblData.cellForRowAtIndexPath(indexPath1) as! ItemsCell
                cell.lblcount?.text=String(format:"%d", a!)as String
            }
            var finalDic:NSDictionary=NSDictionary()
            finalDic=arrayResponse.objectAtIndex((sender.superview?.tag)!) as! NSDictionary
            let changedDic = NSMutableDictionary(dictionary: finalDic)
            changedDic.setValue(changedArray, forKey: "items")
            var array1:NSArray=NSArray()
            array1=self.arrayResponse as NSArray
            let replacedArray = NSMutableArray(array: array1)
            replacedArray[(sender.superview?.tag)!]=changedDic
            self.arrayResponse=replacedArray
        }
        
        
    }
    
    func editClicked(sender:UIButton)  {
        var dic:NSDictionary=NSDictionary()
        dic=arrayResponse.objectAtIndex(sender.tag) as! NSDictionary
        let foundationDictionary = NSMutableDictionary(dictionary: dic)
        foundationDictionary.setValue("Confirmed", forKey: "ORDERS_STATUS")
        foundationDictionary.setValue(arrayResponse.objectAtIndex(sender.tag).valueForKey("ORDERS_TIME")as! String, forKey: "ORDERS_CONFIRMATION_TIME")
        let _ : NSError?
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(foundationDictionary, options: NSJSONWritingOptions.PrettyPrinted)
        
        let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
        
        Alamofire.request(.POST, "http://apps.goodworklabs.com/customer/updateorderstatus", parameters: ["order_str":jsonString])
            .responseJSON { response in switch response.result {
            case .Success(let JSON):
                Datamodel.sharedInstance.hidehud(self.view)
                
                let response = JSON as! NSDictionary
                
                if(response.valueForKey("status")as! NSString == "1"){
                    self.getOrders()
                    
                }
            case .Failure( _):
                Datamodel.sharedInstance.hidehud(self.view)
                }
        }
        
    }
    func buttonClicked(sender:UIButton)  {
        
        if array.contains(sender.tag){
            array.removeObjectsInArray([sender.tag])
            var indexPathArray = [NSIndexPath]()
            
            let count=arrayResponse.objectAtIndex(sender.tag).valueForKey("items")?.count
            for var i = 0; i < count; i += 1 {
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
            for var i = 0; i < count; i += 1 {
                let indexPath = NSIndexPath(forRow: i, inSection: sender.tag)
                indexPathArray.append(indexPath)
                
            }
            
            self.tblData.insertRowsAtIndexPaths(indexPathArray, withRowAnimation: UITableViewRowAnimation.Top)
        }
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
                        
                        print(self.arrayResponse)
                        
                        self.tblData.delegate = self
                        self.tblData.dataSource = self
                        self.tblData.reloadData()
                      // self.deleteOrder("710")
                        
                        //self.logout()
                    }
                    
                    else{
                        self.arrayResponse.removeAllObjects()
                        self.tblData.delegate = self
                        self.tblData.dataSource = self
                        self.tblData.reloadData()
                    }
                    //self.logout()

                    
                    
                    
                    
                    
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
            
            Alamofire.request(.POST, "http://apps.goodworklabs.com/customer/logout", parameters: ["waiter_id":waiterID,"device_type":"ios"])
                .responseJSON { response in switch response.result {
                case .Success(let JSON):
                    print("  JSON: \(JSON)")
                    Datamodel.sharedInstance.hidehud(self.view)
                    
                    let response = JSON as! NSDictionary
                    
                    if(response.valueForKey("status")as! NSString == "1"){
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    }
                    
                    
                case .Failure( _):
                    Datamodel.sharedInstance.hidehud(self.view)
                    
                    }
            }
            

            
            
            }
        }
   // }
    
    
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
                    self.getOrders()

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
