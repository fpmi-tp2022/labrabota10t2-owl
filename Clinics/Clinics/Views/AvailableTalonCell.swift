//
//  AvailableTalonCell.swift
//  Clinics
//
//  Created by Mac on 6/7/22.
//

import UIKit

protocol DeleteTalonDelegate {
    func deleteTalon(talon:Talons)
}

class AvailableTalonCell: UITableViewCell {
    
    var delegate: DeleteTalonDelegate?
    var talon: Talons = Talons()

    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cabinetLabel: UILabel!
    
    @IBAction func orderTalon(_ sender: Any) {
        self.delegate?.deleteTalon(talon: talon)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(talon: Talons) {
        self.talon = talon
        self.jobLabel.text = talon.doctor?.job?.name
        self.nameLabel.text = talon.doctor?.name
        self.dateLabel.text = talon.date
        self.cabinetLabel.text = NSLocalizedString("Cab", comment: "") + ": \(talon.cabinet)"
    }

    
}
