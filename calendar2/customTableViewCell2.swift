//
//  customTableViewCell2.swift
//  calendar2
//
//  Created by WV-MAC on 25/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

class customTableViewCell2: UITableViewCell {

    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var courselbl: UILabel!
    @IBOutlet weak var courseimg: UIImageView!
    @IBOutlet weak var coursedate: UILabel!
    @IBOutlet weak var courseenddate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         //courseimg.layer.cornerRadius = courseimg.bounds.size.width / 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
