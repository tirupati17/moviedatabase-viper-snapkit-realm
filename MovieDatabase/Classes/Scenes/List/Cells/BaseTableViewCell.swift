//
//  BaseTableViewCell.swift
//  MovieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright © 2020 Celerstudio. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    var didSetupConstraints = false
    var data: ListViewItemProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ data: ListViewItemProtocol?) {
        self.data = data
    }
}
