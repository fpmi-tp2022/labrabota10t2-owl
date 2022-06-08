//
//  Clinic.swift
//  Clinics
//
//  Created by Mac on 6/6/22.
//

import Foundation
import UIKit
import MapKit

// MARK: Auxiliary structures and classes
struct HospitalDepartment {
    
    var name: String
    var image: UIImage
}

struct Hospital {
    
    var name: String
    var location: String
    var departments: [HospitalDepartment]
}

class Clinic: NSObject, MKAnnotation {
    
    var name: String
    var location: String
    var coordinate: CLLocationCoordinate2D
    var title: String? {
        return name
    }
    
    init(name:String, location: String, coordinate:CLLocationCoordinate2D) {
        self.name = name
        self.location = location
        self.coordinate = coordinate
    }
    
}

class Talon: NSObject {
    
    var job: String
    var doctor: String
    var date: String
    var cabinet: Float
    
    init(job: String, doctor: String, date: String, cabinet: Float) {
        self.job = job
        self.doctor = doctor
        self.date = date
        self.cabinet = cabinet
    }
}
