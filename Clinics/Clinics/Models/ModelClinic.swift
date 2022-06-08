//
//  ModelClinic.swift
//  Clinics
//
//  Created by Mac on 6/6/22.
//

import Foundation
import UIKit
import MapKit
import CoreData

// MARK: Hospital Model (.plist)
class ModelHospital {
    
    var hospitalsArray : NSArray?
    var hospitals = [Hospital]()
    
    init() {
        setup()
    }
    
    func setup() {
        
        let path = Bundle.main.path(forResource: "HospitalsData", ofType: "plist")
        hospitalsArray = NSArray(contentsOfFile: path!)
        
        for hospitalElement in hospitalsArray! {
            var departments = [HospitalDepartment]()
            let hospitalDepartments = (hospitalElement as AnyObject).value(forKey: "departments") as! NSArray
            for departmentElement in hospitalDepartments {
                let department = HospitalDepartment(name: NSLocalizedString((departmentElement as AnyObject).value(forKey: "departmentName") as! String, comment: ""), image: UIImage(named: (departmentElement as AnyObject).value(forKey: "image") as! String)!)
                departments.append(department)
            }
            
            let hospital = Hospital(name: NSLocalizedString((hospitalElement as AnyObject).value(forKey: "name") as! String, comment: ""), location: NSLocalizedString((hospitalElement as AnyObject).value(forKey: "location") as! String, comment: ""), departments: departments)
            hospitals.append(hospital)
        }
    }
}

// MARK: Clinic Model (Core Data)
class ModelClinic {
    
    var clinics = [[Clinic]]()
    
    var adultClinics:[AdultClinics] = []
    var childClinics:[ChildClinics] = []
    
    var users:[Users] = []
        
    init(firstInit: Bool) {
        setup(firstInit: firstInit)
    }
    
    func setup(firstInit: Bool) {
        
        // MARK: To delete all initial information
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            self.users = try managedObjectContext.fetch(fetchRequest) as! [Users]
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        for user in users {
            managedObjectContext.delete(user as NSManagedObject)
        }
        
        readAdultClinics()
        readChildClinics()
        
        for adultClinic in adultClinics {
            managedObjectContext.delete(adultClinic as NSManagedObject)
        }
        
        for childClinic in childClinics {
            managedObjectContext.delete(childClinic as NSManagedObject)
        }
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Data saving error: \(error)")
        }*/
        
        // MARK: To overwrite all initial information
        if firstInit {
            
            self.saveAdultClinic(name: NSLocalizedString("40th city clinical polyclinic", comment: ""), latitude: 53.932050, longitude: 27.440409, location: NSLocalizedString("3 Lyutsinskaya str., Minsk", comment: ""), ind: 0)
            self.saveAdultClinic(name: NSLocalizedString("26th city polyclinic", comment: ""), latitude: 53.911227, longitude: 27.437730, location: NSLocalizedString("Kuntsevshchyna str. 8, Minsk", comment: ""), ind: 1)
            
            
            self.saveChildClinic(name: NSLocalizedString("4th city children's polyclinic", comment: ""), latitude: 53.926090, longitude: 27.435297, location: NSLocalizedString("Nalibokskaya str. 15, Minsk", comment: ""), ind: 0)
            self.saveChildClinic(name: NSLocalizedString("5th city Children's Clinical polyclinic", comment: ""), latitude: 53.912496, longitude: 27.441158, location: NSLocalizedString("22 Kuntsevshchyna str., Minsk", comment: ""), ind: 1)
        }
        
        readAdultClinics()
        readChildClinics()
        
        let adultClinic1 = Clinic(name: adultClinics[0].name!, location: self.adultClinics[0].location ?? "", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(adultClinics[0].latitude), longitude: CLLocationDegrees(adultClinics[0].longitude)))
        let adultClinic2 = Clinic(name: adultClinics[1].name!, location: adultClinics[1].location ?? "", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(adultClinics[1].latitude), longitude: CLLocationDegrees(adultClinics[1].longitude)))
        
        let adultClinicArray = [adultClinic1, adultClinic2]
        
        let childClinic1 = Clinic(name: childClinics[0].name!, location: childClinics[0].location ?? "", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(childClinics[0].latitude), longitude: CLLocationDegrees(childClinics[0].longitude)))
        let childClinic2 = Clinic(name: childClinics[1].name!, location: childClinics[1].location ?? "", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(childClinics[1].latitude), longitude: CLLocationDegrees(childClinics[1].longitude)))
        
        let childChilicArray = [childClinic1, childClinic2]
        
        clinics.append(adultClinicArray)
        clinics.append(childChilicArray)
        
    }
    
    // MARK: Read information from database
    func readAdultClinics() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AdultClinics")
        
        do {
            self.adultClinics = try context.fetch(fetchRequest) as! [AdultClinics]
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func readChildClinics() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChildClinics")
        
        do {
            self.childClinics = try context.fetch(fetchRequest) as! [ChildClinics]
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Write information to database
    func saveAdultClinic(name: String, latitude: Float, longitude: Float, location: String, ind: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var clinics = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AdultClinics")
        do {
            clinics = try (context.fetch(fetchRequest) as? [NSManagedObject])!
        } catch {
            print("Error")
        }
        
        if clinics.count > ind {
            return
        }
        
        if ind == 0 {
            
            guard let entityTalons = NSEntityDescription.entity(forEntityName: "Talons", in: context) else { return }
            
            let talonObject1 = Talons(entity: entityTalons, insertInto: context)
            talonObject1.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject1.cabinet = 100
            let talonObject2 = Talons(entity: entityTalons, insertInto: context)
            talonObject2.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject2.cabinet = 100
            let talonObject3 = Talons(entity: entityTalons, insertInto: context)
            talonObject3.date = "10:00 25 " + NSLocalizedString("June", comment: "")
            talonObject3.cabinet = 100
            let talonObject4 = Talons(entity: entityTalons, insertInto: context)
            talonObject4.date = "11:00 25 " + NSLocalizedString("June", comment: "")
            talonObject4.cabinet = 100
            let talonObject5 = Talons(entity: entityTalons, insertInto: context)
            talonObject5.date = "12:00 25 " + NSLocalizedString("June", comment: "")
            talonObject5.cabinet = 100
            
            let talonObject6 = Talons(entity: entityTalons, insertInto: context)
            talonObject6.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject6.cabinet = 200
            let talonObject7 = Talons(entity: entityTalons, insertInto: context)
            talonObject7.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject7.cabinet = 200
            let talonObject8 = Talons(entity: entityTalons, insertInto: context)
            talonObject8.date = "10:00 25 " + NSLocalizedString("June", comment: "")
            talonObject8.cabinet = 200
            
            let talonObject11 = Talons(entity: entityTalons, insertInto: context)
            talonObject11.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject11.cabinet = 300
            let talonObject12 = Talons(entity: entityTalons, insertInto: context)
            talonObject12.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject12.cabinet = 300
            let talonObject13 = Talons(entity: entityTalons, insertInto: context)
            talonObject13.date = "10:00 25 " + NSLocalizedString("June", comment: "")
            talonObject13.cabinet = 300
            
            let talonObject16 = Talons(entity: entityTalons, insertInto: context)
            talonObject16.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject16.cabinet = 400
            let talonObject17 = Talons(entity: entityTalons, insertInto: context)
            talonObject17.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject17.cabinet = 400
            let talonObject18 = Talons(entity: entityTalons, insertInto: context)
            talonObject18.date = "10:00 25 " + NSLocalizedString("June", comment: "")
            talonObject18.cabinet = 400
            
            let talonObject21 = Talons(entity: entityTalons, insertInto: context)
            talonObject21.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject21.cabinet = 500
            let talonObject22 = Talons(entity: entityTalons, insertInto: context)
            talonObject22.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject22.cabinet = 500
            let talonObject23 = Talons(entity: entityTalons, insertInto: context)
            talonObject23.date = "10:00 25 " + NSLocalizedString("June", comment: "")
            talonObject23.cabinet = 500
            
            let talonSet1:NSSet = [talonObject1, talonObject2, talonObject3]
            let talonSet2:NSSet = [talonObject6, talonObject7, talonObject8]
            let talonSet3:NSSet = [talonObject11, talonObject12, talonObject13]
            let talonSet4:NSSet = [talonObject16, talonObject17, talonObject18]
            let talonSet5:NSSet = [talonObject21, talonObject22, talonObject23]
            let talonSet6:NSSet = [talonObject4, talonObject5]

            
            guard let entityDoctors = NSEntityDescription.entity(forEntityName: "Doctors", in: context) else { return }
            
            let doctorObject1 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject1.name = NSLocalizedString("Ivanova Yulia Vladimirovna", comment: "")
            let doctorObject2 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject2.name = NSLocalizedString("Gorenkova Tatiana Vladimirovna", comment: "")
            let doctorObject3 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject3.name = NSLocalizedString("Ahapkina Anastasia Mikhailovna", comment: "")
            let doctorObject4 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject4.name = NSLocalizedString("Bernard Ulyana Konstantinovna", comment: "")
            let doctorObject5 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject5.name = NSLocalizedString("Kulik Svetlana Mikhailovna", comment: "")
            let doctorObject6 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject6.name = NSLocalizedString("Kosik Tatiana Silvestrovna", comment: "")
            
            doctorObject1.addToTalon(talonSet1)
            doctorObject2.addToTalon(talonSet2)
            doctorObject3.addToTalon(talonSet3)
            doctorObject4.addToTalon(talonSet4)
            doctorObject5.addToTalon(talonSet5)
            doctorObject6.addToTalon(talonSet6)
            
            let therapistsArray:NSSet = [doctorObject3, doctorObject2, doctorObject1]
            let oculistsArray:NSSet = [doctorObject4, doctorObject5]
            let entsArray:NSSet = [doctorObject6]
            
            guard let entityJobs = NSEntityDescription.entity(forEntityName: "Jobs", in: context) else { return }
            
            let jobObject1 = Jobs(entity: entityJobs, insertInto: context)
            jobObject1.name = NSLocalizedString("Ent", comment: "")
            let jobObject2 = Jobs(entity: entityJobs, insertInto: context)
            jobObject2.name = NSLocalizedString("Optometrist", comment: "")
            let jobObject3 = Jobs(entity: entityJobs, insertInto: context)
            jobObject3.name = NSLocalizedString("Therapist", comment: "")
            
            jobObject1.addToDoctor(entsArray)
            jobObject2.addToDoctor(oculistsArray)
            jobObject3.addToDoctor(therapistsArray)
            
            let jobsArray:NSSet = [jobObject1, jobObject2, jobObject3]
            
            guard let entity = NSEntityDescription.entity(forEntityName: "AdultClinics", in: context) else { return }

            let clinicObject1 = AdultClinics(entity: entity, insertInto: context)
            clinicObject1.name = name
            clinicObject1.location = location
            clinicObject1.latitude = latitude
            clinicObject1.longitude = longitude
            clinicObject1.addToJob(jobsArray)
            
        } else if ind == 1 {
            
            guard let entityTalons = NSEntityDescription.entity(forEntityName: "Talons", in: context) else { return }
            
            let talonObject9 = Talons(entity: entityTalons, insertInto: context)
            talonObject9.date = "11:00 25 " + NSLocalizedString("June", comment: "")
            talonObject9.cabinet = 200
            let talonObject10 = Talons(entity: entityTalons, insertInto: context)
            talonObject10.date = "12:00 25 " + NSLocalizedString("June", comment: "")
            talonObject10.cabinet = 200
            
            let talonObject14 = Talons(entity: entityTalons, insertInto: context)
            talonObject14.date = "11:00 25 " + NSLocalizedString("June", comment: "")
            talonObject14.cabinet = 300
            let talonObject15 = Talons(entity: entityTalons, insertInto: context)
            talonObject15.date = "12:00 25 " + NSLocalizedString("June", comment: "")
            talonObject15.cabinet = 300
            
            let talonObject19 = Talons(entity: entityTalons, insertInto: context)
            talonObject19.date = "11:00 25 " + NSLocalizedString("June", comment: "")
            talonObject19.cabinet = 400
            let talonObject20 = Talons(entity: entityTalons, insertInto: context)
            talonObject20.date = "12:00 25 " + NSLocalizedString("June", comment: "")
            talonObject20.cabinet = 400
            
            let talonSet7:NSSet = [talonObject9, talonObject10]
            let talonSet8:NSSet = [talonObject14, talonObject15]
            let talonSet9:NSSet = [talonObject19, talonObject20]
            
            guard let entityDoctors = NSEntityDescription.entity(forEntityName: "Doctors", in: context) else { return }
            
            let doctorObject7 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject7.name = NSLocalizedString("Avdeyuk Alexandra Andreevna", comment: "")
            let doctorObject8 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject8.name = NSLocalizedString("Kolondenok Vita Vitalievna", comment: "")
            let doctorObject9 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject9.name = NSLocalizedString("Prigorovskaya Natalia Feodosievna", comment: "")
            
            doctorObject7.addToTalon(talonSet7)
            doctorObject8.addToTalon(talonSet8)
            doctorObject9.addToTalon(talonSet9)
            
            guard let entityJobs = NSEntityDescription.entity(forEntityName: "Jobs", in: context) else { return }
            
            let jobObject4 = Jobs(entity: entityJobs, insertInto: context)
            jobObject4.name = NSLocalizedString("Ent", comment: "")
            let jobObject5 = Jobs(entity: entityJobs, insertInto: context)
            jobObject5.name = NSLocalizedString("Optometrist", comment: "")
            let jobObject6 = Jobs(entity: entityJobs, insertInto: context)
            jobObject6.name = NSLocalizedString("Therapist", comment: "")
            
            jobObject4.addToDoctor([doctorObject7])
            jobObject5.addToDoctor([doctorObject8])
            jobObject6.addToDoctor([doctorObject9])
            
            let jobsArray2:NSSet = [jobObject4, jobObject5, jobObject6]
            
            guard let entity = NSEntityDescription.entity(forEntityName: "AdultClinics", in: context) else { return }
            
            let clinicObject2 = AdultClinics(entity: entity, insertInto: context)
            clinicObject2.name = name
            clinicObject2.location = location
            clinicObject2.latitude = latitude
            clinicObject2.longitude = longitude
            clinicObject2.addToJob(jobsArray2)
        }
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func saveChildClinic(name: String, latitude: Float, longitude: Float, location: String, ind: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var clinics = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChildClinics")
        do {
            clinics = try (context.fetch(fetchRequest) as? [NSManagedObject])!
        } catch {
            print("Error")
        }
        
        if clinics.count > ind {
            return
        }
        
        if ind == 0 {
            
            guard let entityTalons = NSEntityDescription.entity(forEntityName: "Talons", in: context) else { return }
            
            let talonObject1 = Talons(entity: entityTalons, insertInto: context)
            talonObject1.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject1.cabinet = 100
            let talonObject2 = Talons(entity: entityTalons, insertInto: context)
            talonObject2.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject2.cabinet = 100
            
            let talonObject3 = Talons(entity: entityTalons, insertInto: context)
            talonObject3.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject3.cabinet = 200
            let talonObject4 = Talons(entity: entityTalons, insertInto: context)
            talonObject4.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject4.cabinet = 200
            
            let talonObject5 = Talons(entity: entityTalons, insertInto: context)
            talonObject5.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject5.cabinet = 300
            let talonObject6 = Talons(entity: entityTalons, insertInto: context)
            talonObject6.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject6.cabinet = 300
            
            let talonSet1:NSSet = [talonObject1, talonObject2]
            let talonSet2:NSSet = [talonObject3, talonObject4]
            let talonSet3:NSSet = [talonObject5, talonObject6]
            
            guard let entityDoctors = NSEntityDescription.entity(forEntityName: "Doctors", in: context) else { return }
            
            let doctorObject1 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject1.name = NSLocalizedString("Stalkova Galina Vasilyevna", comment: "")
            let doctorObject2 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject2.name = NSLocalizedString("Zachatko Elena Aleksandrovna", comment: "")
            let doctorObject3 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject3.name = NSLocalizedString("Didyulya Valery Pavlovich", comment: "")
            
            doctorObject1.addToTalon(talonSet1)
            doctorObject2.addToTalon(talonSet2)
            doctorObject3.addToTalon(talonSet3)
            
            guard let entityJobs = NSEntityDescription.entity(forEntityName: "Jobs", in: context) else { return }
            
            let jobObject1 = Jobs(entity: entityJobs, insertInto: context)
            jobObject1.name = NSLocalizedString("Orthopedist", comment: "")
            let jobObject2 = Jobs(entity: entityJobs, insertInto: context)
            jobObject2.name = NSLocalizedString("Dentist", comment: "")
            let jobObject3 = Jobs(entity: entityJobs, insertInto: context)
            jobObject3.name = NSLocalizedString("Pediatrician", comment: "")
            
            jobObject1.addToDoctor([doctorObject2])
            jobObject2.addToDoctor([doctorObject3])
            jobObject3.addToDoctor([doctorObject1])
            
            let jobsArray:NSSet = [jobObject1, jobObject2, jobObject3]
            
            guard let entity = NSEntityDescription.entity(forEntityName: "ChildClinics", in: context) else { return }

            let clinicObject1 = ChildClinics(entity: entity, insertInto: context)
            clinicObject1.name = name
            clinicObject1.location = location
            clinicObject1.latitude = latitude
            clinicObject1.longitude = longitude
            clinicObject1.addToJob(jobsArray)
            
        } else if ind == 1 {
            
            guard let entityTalons = NSEntityDescription.entity(forEntityName: "Talons", in: context) else { return }
            
            let talonObject7 = Talons(entity: entityTalons, insertInto: context)
            talonObject7.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject7.cabinet = 100
            let talonObject8 = Talons(entity: entityTalons, insertInto: context)
            talonObject8.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject8.cabinet = 100
            
            let talonObject9 = Talons(entity: entityTalons, insertInto: context)
            talonObject9.date = "08:00 25 " + NSLocalizedString("June", comment: "")
            talonObject9.cabinet = 200
            let talonObject10 = Talons(entity: entityTalons, insertInto: context)
            talonObject10.date = "09:00 25 " + NSLocalizedString("June", comment: "")
            talonObject10.cabinet = 200
            
            let talonSet4:NSSet = [talonObject7, talonObject8]
            let talonSet5:NSSet = [talonObject9, talonObject10]
            
            guard let entityDoctors = NSEntityDescription.entity(forEntityName: "Doctors", in: context) else { return }
            
            let doctorObject4 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject4.name = NSLocalizedString("Ivanova Ulyana Dmitrievna", comment: "")
            let doctorObject5 = Doctors(entity: entityDoctors, insertInto: context)
            doctorObject5.name = NSLocalizedString("Ivanova Svetlana Dmitrievna", comment: "")
            
            doctorObject4.addToTalon(talonSet4)
            doctorObject5.addToTalon(talonSet5)
            
            guard let entityJobs = NSEntityDescription.entity(forEntityName: "Jobs", in: context) else { return }
            
            let jobObject4 = Jobs(entity: entityJobs, insertInto: context)
            jobObject4.name = NSLocalizedString("Pediatrician", comment: "")
            let jobObject5 = Jobs(entity: entityJobs, insertInto: context)
            jobObject5.name = NSLocalizedString("Neurologist", comment: "")
            
            jobObject4.addToDoctor([doctorObject4])
            jobObject5.addToDoctor([doctorObject5])
            
            let jobsArray2:NSSet = [jobObject4, jobObject5]
            
            guard let entity = NSEntityDescription.entity(forEntityName: "ChildClinics", in: context) else { return }

            let clinicObject2 = ChildClinics(entity: entity, insertInto: context)
            clinicObject2.name = name
            clinicObject2.location = location
            clinicObject2.latitude = latitude
            clinicObject2.longitude = longitude
            clinicObject2.addToJob(jobsArray2)
        }
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
