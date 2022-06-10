//
//  DoctorCell.swift
//  Clinics
//
//  Created by Mac on 6/7/22.
//

import UIKit

class DoctorCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(doctor: Doctors) {
        self.nameLabel.text = doctor.name
    }
    
}
