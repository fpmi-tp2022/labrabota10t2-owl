//
//  AvailableTalonsViewController.swift
//  Clinics
//
//  Created by Mac on 6/7/22.
//

import UIKit
import CoreData

class AvailableTalonsViewController: UIViewController, DeleteTalonDelegate {
    
    // MARK: Implementing delegate functions
    func deleteTalon(talon: Talons){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var users = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
            users = try (context.fetch(fetchRequest) as? [NSManagedObject])!
        } catch {
            print("Error")
        }
        
        if users.count == 0 {
            
            guard let entityMyTalons = NSEntityDescription.entity(forEntityName: "MyTalons", in: context) else { return }
            let talonObject = MyTalons(entity: entityMyTalons, insertInto: context)
            talonObject.job = talon.doctor?.job?.name
            talonObject.doctor = talon.doctor?.name
            talonObject.date = talon.date
            talonObject.cabinet = talon.cabinet
            guard let entityUsers = NSEntityDescription.entity(forEntityName: "Users", in: context) else { return }
            let userObject = Users(entity: entityUsers, insertInto: context)
            userObject.addToMyTalon(talonObject)
        } else {
            
            guard let entityMyTalons = NSEntityDescription.entity(forEntityName: "MyTalons", in: context) else { return }
            let talonObject = MyTalons(entity: entityMyTalons, insertInto: context)
            talonObject.job = talon.doctor?.job?.name
            talonObject.doctor = talon.doctor?.name
            talonObject.date = talon.date
            talonObject.cabinet = talon.cabinet
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            var user:[Users] = []
            
            do {
                user = try context.fetch(fetchRequest) as! [Users]
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            user[0].addToMyTalon(talonObject)
        }
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        context.delete(talon as NSManagedObject)
        
        do {
            try context.save()
            let index = talons.firstIndex(of: talon)
            talons.remove(at: index!)
            self.tableView.reloadData()
            
        } catch let error as NSError {
            print("Data saving error: \(error)")
        }
    }
    
    // MARK: Variables
    var talons: [Talons] = []
    var doctors: [Doctors] = []
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Available talons", comment: "")
        
        self.tableView.register(UINib(nibName: "AvailableTalonCell", bundle: nil), forCellReuseIdentifier: "AvailableTalonCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Doctors")
        
        do {
            self.doctors = try context.fetch(fetchRequest) as! [Doctors]
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        for doctor in doctors {
            if doctor.name == talons[0].doctor?.name {
                talons = doctor.talon?.allObjects as! [Talons]
                break
            }
        }
    }
    
}

// MARK: Extensions
// MARK: Table view
extension AvailableTalonsViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableTalonCell", for: indexPath) as! AvailableTalonCell
        cell.setupCell(talon: talons[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
