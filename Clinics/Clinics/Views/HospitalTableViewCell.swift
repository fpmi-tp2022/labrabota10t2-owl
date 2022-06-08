//
//  HospitalTableViewCell.swift
//  Clinics
//
//  Created by Mac on 6/8/22.
//

import UIKit

class HospitalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(hospital: Hospital) {
        self.nameLabel.text = hospital.name
        self.locationLabel.text = hospital.location
    }
    
}
