//
//  PopupTableViewController.swift
//  Clinics
//
//  Created by Mac on 6/6/22.
//

import UIKit
import CoreData

protocol ChangeSelectedAdultClinicDelegate {
    func changeSelectedAdultClinic(clinic:Clinic)
}

class PopupTableViewController: UITableViewController {
    
    var delegate: ChangeSelectedAdultClinicDelegate?
    let modelClinic = ModelClinic(firstInit: false)

    override func viewDidLoad() {
        super.viewDidLoad()        
        tableView.isScrollEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 300, height: tableView.contentSize.height)
    }

    // MARK: - Table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelClinic.clinics[0].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let textData = modelClinic.clinics[0][indexPath.row].name
        cell.textLabel?.text = textData

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.changeSelectedAdultClinic(clinic: modelClinic.clinics[0][indexPath.row])
    }

}
