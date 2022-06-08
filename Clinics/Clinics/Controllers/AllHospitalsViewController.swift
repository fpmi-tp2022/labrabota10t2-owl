//
//  AllHospitalsViewController.swift
//  Clinics
//
//  Created by Mac on 6/8/22.
//

import UIKit

class AllHospitalsViewController: UIViewController {
    
    // MARK: Variables
    let hospitals = ModelHospital()

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Hospitals", comment: "")
        
        self.tableView.register(UINib(nibName: "HospitalTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

}

// MARK: Extensions
// MARK: Table view
extension AllHospitalsViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalTableViewCell", for: indexPath) as! HospitalTableViewCell
        cell.setupCell(hospital: hospitals.hospitals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HospitalsViewController") as? HospitalsViewController {
            vc.hospital = self.hospitals.hospitals[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
