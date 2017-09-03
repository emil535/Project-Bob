//
//  MemberTableViewCell.swift
//  Project Bob
//
//  Created by Emil Safier on 3/11/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//  [ Bob-3 version]

import UIKit

class MemberTableViewCell: UITableViewCell {

    //  MARK: - Outlets
  
    //  Outlets from CUSTOM Cell
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memberCityLabel: UILabel!
    @IBOutlet weak var memberStatusLabel: UILabel!
    @IBOutlet weak var memberSwiftLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
