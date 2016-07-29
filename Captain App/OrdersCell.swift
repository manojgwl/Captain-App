//
//  OrdersCell.swift
//  Captain App
//
//  Created by manojkumar Jonna on 26/07/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

import UIKit

class OrdersCell: UITableViewCell {

    @IBOutlet weak var lblOrder: UILabel?
    @IBOutlet weak var lblTime: UILabel?

    @IBOutlet weak var btnUpdate: UIButton?
    @IBOutlet weak var btnEDit: UIButton?
    @IBOutlet weak var btnDelete: UIButton?
    @IBOutlet weak var viewBG: UIView?



    @IBOutlet weak var lblTableNo: UILabel?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
