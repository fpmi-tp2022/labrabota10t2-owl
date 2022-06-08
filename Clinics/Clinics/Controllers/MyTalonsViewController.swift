//
//  MyTalonsViewController.swift
//  Clinics
//
//  Created by Mac on 6/7/22.
//

import UIKit
import CoreData

class MyTalonsViewController: UIViewController, DeleteMyTalonDelegate {
    
    // MARK: Implementing delegate functions
    func deleteMyTalon(talon: MyTalons) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Doctors")
        
        do {
            self.doctors = try context.fetch(fetchRequest) as! [Doctors]
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        for doctor in doctors {
            if doctor.name == talon.doctor {
                guard let entityTalons = NSEntityDescription.entity(forEntityName: "Talons", in: context) else { return }
                let talonObject = Talons(entity: entityTalons, insertInto: context)
                talonObject.date = talon.date
                talonObject.cabinet = talon.cabinet
                doctor.addToTalon(talonObject)
                break
            }
        }
        
        context.delete(talon as NSManagedObject)
        
        do {
            try context.save()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            do {
                self.user = try context.fetch(fetchRequest) as! [Users]
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            self.tableView.reloadData()
            
        } catch let error as NSError {
            print("Data saving error: \(error)")
        }
    }
    
    // MARK: Variables
    var user: [Users] = []
    var doctors:[Doctors] = []

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("My talons", comment: "")
        
        self.tableView.register(UINib(nibName: "MyTalonCell", bundle: nil), forCellReuseIdentifier: "MyTalonCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            self.user = try context.fetch(fetchRequest) as! [Users]
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}

// MARK: Extensions
// MARK: Table view
extension MyTalonsViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = user.first?.myTalon?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTalonCell", for: indexPath) as! MyTalonCell
        cell.setupCell(talon: (user[0].myTalon?.allObjects as! [MyTalons])[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
