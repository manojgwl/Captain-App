//
//  ItemsCell.swift
//  Captain App
//
//  Created by manojkumar Jonna on 26/07/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

import UIKit

class ItemsCell: UITableViewCell {
    @IBOutlet weak var lblFoodName: UILabel?
    @IBOutlet weak var lblcount: UILabel?
    @IBOutlet weak var btnPlus: UIButton?
    @IBOutlet weak var btnMinus: UIButton?
    @IBOutlet weak var lblorderType: UILabel?





    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
