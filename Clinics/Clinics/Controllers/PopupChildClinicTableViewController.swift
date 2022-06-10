//
//  PopupChildClinicTableViewController.swift
//  Clinics
//
//  Created by Mac on 6/6/22.
//

import UIKit

protocol ChangeSelectedChildClinicDelegate {
    func changeSelectedChildClinic(clinic:Clinic)
}

class PopupChildClinicTableViewController: UITableViewController {
    
    var delegate: ChangeSelectedChildClinicDelegate?    
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
        return self.modelClinic.clinics[1].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath)

        let textData = modelClinic.clinics[1][indexPath.row].name
        cell.textLabel?.text = textData

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.changeSelectedChildClinic(clinic: modelClinic.clinics[1][indexPath.row])
    }
}
