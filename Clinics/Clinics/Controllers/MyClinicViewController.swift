//
//  MyClinicViewController.swift
//  Clinics
//
//  Created by Mac on 6/6/22.
//

import UIKit
import MapKit

class MyClinicViewController: UIViewController {
    
    // MARK: Variables
    var clinicClass = Clinic(name: "", location: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    var adultClinic: AdultClinics = AdultClinics()
    var childClinic: ChildClinics = ChildClinics()
    var isAdultClinic: Bool = true

    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: IBActions
    @IBAction func orderTalon(_ sender: Any) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SpecialistViewController") as? SpecialistViewController {
            if isAdultClinic {
                vc.jobs = adultClinic.job?.allObjects as! [Jobs]
            } else {
                vc.jobs = childClinic.job?.allObjects as! [Jobs]
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("My clinic", comment: "")
        
        self.nameLabel.text = clinicClass.name
        self.locationLabel.text = clinicClass.location
    }    

}
