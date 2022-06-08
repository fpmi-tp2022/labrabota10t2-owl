//
//  HospitalCollectionViewCell.swift
//  Clinics
//
//  Created by Mac on 6/8/22.
//

import UIKit

class HospitalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(department: HospitalDepartment) {
        self.departmentLabel.text = department.name
        self.imageView.image = department.image
    }

}
