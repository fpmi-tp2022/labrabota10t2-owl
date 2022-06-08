//
//  SpecialistCell.swift
//  Clinics
//
//  Created by Mac on 6/7/22.
//

import UIKit
import CoreData

class SpecialistCell: UITableViewCell {

    @IBOutlet weak var specialistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(job: Jobs) {
        self.specialistLabel.text = job.name
    }
    
}
