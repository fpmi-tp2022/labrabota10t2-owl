//
//  DoctorViewController.swift
//  Clinics
//
//  Created by Mac on 6/7/22.
//

import UIKit
import CoreData

class DoctorViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    var doctors: [Doctors] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = doctors[0].job?.name
        
        self.tableView.register(UINib(nibName: "DoctorCell", bundle: nil), forCellReuseIdentifier: "DoctorCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }    

}

// MARK: Extensions
// MARK: Table view
extension DoctorViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath) as! DoctorCell
        cell.setupCell(doctor: doctors[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AvailableTalonsViewController") as? AvailableTalonsViewController {
            vc.talons = doctors[indexPath.row].talon?.allObjects as! [Talons]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
