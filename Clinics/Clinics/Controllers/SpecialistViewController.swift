//
//  SpecialistViewController.swift
//  Clinics
//
//  Created by Mac on 6/7/22.
//

import UIKit
import CoreData

class SpecialistViewController: UIViewController {
    
    // MARK: Variables
    var jobs: [Jobs] = []

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Ordering a talon", comment: "")
        
        self.tableView.register(UINib(nibName: "SpecialistCell", bundle: nil), forCellReuseIdentifier: "SpecialistCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

}

// MARK: Extensions
// MARK: Table view
extension SpecialistViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialistCell", for: indexPath) as! SpecialistCell
        cell.setupCell(job: jobs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DoctorViewController") as? DoctorViewController {
            vc.doctors = jobs[indexPath.row].doctor?.allObjects as! [Doctors]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
