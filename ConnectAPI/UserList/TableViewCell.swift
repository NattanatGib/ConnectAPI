//
//  TableViewCell.swift
//  ConnectAPI
//
//  Created by gibntn on 27/7/2563 BE.
//  Copyright © 2563 nattanat. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    


    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
