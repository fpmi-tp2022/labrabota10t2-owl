//
//  ClinicsTests.swift
//  ClinicsTests
//
//  Created by Mac on 6/6/22.
//

import XCTest
import MapKit
@testable import Clinics

class ClinicsTests: XCTestCase {

    var sut: MapViewController!
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        sut = MapViewController()
    }

    override func tearDownWithError() throws {
        
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testChangeSelectedAdultClinicFunction() {
        
        let clinic = Clinic(name: "CLINIC", location: "LOCATION", coordinate: CLLocationCoordinate2D(latitude: 53.0, longitude: 25.0))
        sut.adultClinicLabel = UILabel()
        sut.changeSelectedAdultClinic(clinic: clinic)
        XCTAssertEqual(sut.selectedAdultClinic, clinic, "Selected adult clinic has not changed")
    }
    
    func testChangeSelectedChildClinicFunction() {
        
        let clinic = Clinic(name: "CHILDCLINIC", location: "LOCATION", coordinate: CLLocationCoordinate2D(latitude: 53.0, longitude: 25.0))
        sut.childClinicLabel = UILabel()
        sut.changeSelectedChildClinic(clinic: clinic)
        XCTAssertEqual(sut.selectedChildClinic, clinic, "Selected child clinic has not changed")
    }

}
