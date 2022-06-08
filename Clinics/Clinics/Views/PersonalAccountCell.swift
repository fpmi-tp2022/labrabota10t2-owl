//
//  PersonalAccountCell.swift
//  Clinics
//
//  Created by Mac on 6/6/22.
//

import UIKit

class PersonalAccountCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name: String) {
        self.nameLabel.text = name
    }

}
