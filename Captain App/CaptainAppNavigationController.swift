//
//  CaptainAppNavigationController.swift
//  Captain App
//
//  Created by Shabeer on 25/07/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

import UIKit

class CaptainAppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        //self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Merriweather", size: 20)!]
      //  self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Merriweather-Light", size: 34)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        if let font = UIFont (name: "Merriweather", size: 15) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font,NSForegroundColorAttributeName: UIColor.whiteColor()]
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
