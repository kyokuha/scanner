//
//  ScanedCell.swift
//  BarcodeScan
//
//  Created by 曲波 on 2019/12/22.
//  Copyright © 2019 曲波. All rights reserved.
//

import UIKit

class ScanedCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var data: [String] = [] {
        didSet{
//            label.text = 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
