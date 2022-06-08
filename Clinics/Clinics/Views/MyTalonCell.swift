//
//  MyTalonCell.swift
//  Clinics
//
//  Created by Mac on 6/7/22.
//

import UIKit

protocol DeleteMyTalonDelegate {
    func deleteMyTalon(talon:MyTalons)
}

class MyTalonCell: UITableViewCell {
    
    var delegate: DeleteMyTalonDelegate?
    var talon:MyTalons = MyTalons()
    
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cabinetLabel: UILabel!
    
    @IBAction func deleteTalon(_ sender: Any) {
        self.delegate?.deleteMyTalon(talon: talon)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(talon:MyTalons) {
        
        self.talon = talon
        self.jobLabel.text = talon.job
        self.nameLabel.text = talon.doctor
        self.dateLabel.text = talon.date
        self.cabinetLabel.text = NSLocalizedString("Cab", comment: "") + ": \(talon.cabinet)"
    }
    
}
