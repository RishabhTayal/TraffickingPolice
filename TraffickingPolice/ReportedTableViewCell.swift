//
//  ReportedTableViewCell.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 1/12/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class ReportedTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
