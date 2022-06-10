//
//  PersonalAccountViewController.swift
//  Clinics
//
//  Created by Mac on 6/6/22.
//

import UIKit
import MapKit
import CoreData

class PersonalAccountViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    let cellNames = [NSLocalizedString("My clinic", comment: ""), NSLocalizedString("Children's polyclinic", comment: ""), NSLocalizedString("Hospitals", comment: ""), NSLocalizedString("My talons", comment: "")]
    
    var adultClinicClass = Clinic(name: "", location: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    var childClinicClass = Clinic(name: "", location: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    var adultClinic: AdultClinics = AdultClinics()
    var childClinic: ChildClinics = ChildClinics()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Personal account", comment: "")
        self.collectionView.register(UINib(nibName: "PersonalAccountCell", bundle: nil), forCellWithReuseIdentifier: "PersonalAccountCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

}

// MARK: Extentions
// MARK: Collection View
extension PersonalAccountViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonalAccountCell", for: indexPath) as! PersonalAccountCell
        cell.setupCell(name: cellNames[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MyClinicViewController") as? MyClinicViewController {
                vc.clinicClass = self.adultClinicClass
                vc.adultClinic = self.adultClinic
                vc.isAdultClinic = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.item == 1 {
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MyClinicViewController") as? MyClinicViewController {
                vc.clinicClass = self.childClinicClass
                vc.childClinic = self.childClinic 
                vc.isAdultClinic = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.item == 2 {
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AllHospitalsViewController") as? AllHospitalsViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }            
        } else if indexPath.item == 3 {
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MyTalonsViewController") as? MyTalonsViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
