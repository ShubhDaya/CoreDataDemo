//
//  PersonListCell.swift
//  CoreDataShubham
//
//  Created by ADMIN on 21/03/23.
//

import UIKit

class PersonListCell: UITableViewCell {

    @IBOutlet weak var lblPersonEmail: UILabel!
    @IBOutlet weak var lblPersonName: UILabel!
    @IBOutlet weak var btnDelete: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
