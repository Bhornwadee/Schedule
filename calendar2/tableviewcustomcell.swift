//
//  tableviewcustomcell.swift
//  calendar2
//
//  Created by WV-MAC on 2/7/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

class tableviewcustomcell: UITableViewCell {
    
    @IBOutlet weak var courselbl1: UILabel!
    @IBOutlet weak var courseimg1: UIImageView!
    @IBOutlet weak var CellView1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let myColor : UIColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        courseimg1.layer.masksToBounds = true
        courseimg1.layer.borderWidth = 3
        courseimg1.layer.borderColor = myColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
