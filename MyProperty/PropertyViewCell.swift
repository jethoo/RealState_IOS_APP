//
//  PropertyViewCell.swift
//  MyProperty
//
//  Created by jeewan bhusal on 3.8.2020.
//  Copyright © 2020 MyProperty. All rights reserved.
//

import UIKit

//this view is displayed inside the propertyViewController for showing the values inserted into the array in
//addViewController in the form below
class PropertyViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var house: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var describe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
