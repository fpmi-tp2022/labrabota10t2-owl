//
//  MapViewController.swift
//  Clinics
//
//  Created by Mac on 6/6/22.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, ChangeSelectedAdultClinicDelegate, ChangeSelectedChildClinicDelegate {
    
    // MARK: Implementing delegate functions
    func changeSelectedChildClinic(clinic: Clinic) {
        selectedChildClinic = clinic
        childClinicLabel.text = selectedChildClinic.name
    }
    
    func changeSelectedAdultClinic(clinic: Clinic) {
        selectedAdultClinic = clinic
        adultClinicLabel.text = selectedAdultClinic.name
    }

    // MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var chooseAdultClinicButton: UIButton!
    @IBOutlet weak var chooseChildClinicButton: UIButton!
    @IBOutlet var adultClinicLabel: UILabel!
    @IBOutlet var childClinicLabel: UILabel!
    
    // MARK: IBActions
    @IBAction func saveButton(_ sender: Any) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PersonalAccountViewController") as? PersonalAccountViewController {
            
            vc.adultClinicClass = selectedAdultClinic
            vc.childClinicClass = selectedChildClinic
            for adultClinic in adultClinics {
                if selectedAdultClinic.name == adultClinic.name {
                    vc.adultClinic = adultClinic
                    break
                }
            }
            for childClinic in childClinics {
                if selectedChildClinic.name == childClinic.name {
                    vc.childClinic = childClinic
                    break
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    // MARK: Variables
    let locationManager = CLLocationManager()
    let modelClinic = ModelClinic(firstInit: true)
        
    var selectedAdultClinic:Clinic = Clinic(name: "", location: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    var selectedChildClinic:Clinic = Clinic(name: "", location: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    
    var adultClinics: [AdultClinics] = []
    var childClinics: [ChildClinics] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()

        self.mapView.delegate = self
        for clinics in modelClinic.clinics {
            for clinic in clinics {
                mapView.addAnnotation(clinic)
            }
        }
        
        readAdultClinics()
        readChildClinics()
        
        selectNearestAdultClinic()
        adultClinicLabel.text = self.selectedAdultClinic.name
        selectNearestChildClinic()
        childClinicLabel.text = self.selectedChildClinic.name
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
        
        selectNearestAdultClinic()
        adultClinicLabel.text = self.selectedAdultClinic.name
        selectNearestChildClinic()
        childClinicLabel.text = self.selectedChildClinic.name
    }
    
    // MARK: Functions
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
    
    func selectNearestAdultClinic() {
        
        self.selectedAdultClinic = modelClinic.clinics[0][0]
        
        guard let coordinate = locationManager.location?.coordinate else {
            return
        }
        
        for adultClinic in modelClinic.clinics[0] {
            if sqrt(pow((adultClinic.coordinate.latitude - coordinate.latitude), 2) + pow((adultClinic.coordinate.longitude - coordinate.longitude), 2)) < sqrt(pow((selectedAdultClinic.coordinate.latitude - coordinate.latitude), 2) + pow((selectedAdultClinic.coordinate.longitude - coordinate.longitude), 2)) {
                
                self.selectedAdultClinic = adultClinic
            }
        }
    }
    
    func selectNearestChildClinic() {
        
        self.selectedChildClinic = modelClinic.clinics[1][0]
        
        guard let coordinate = locationManager.location?.coordinate else {
            return
        }
        
        for childClinic in modelClinic.clinics[1] {
            if sqrt(pow((childClinic.coordinate.latitude - coordinate.latitude), 2) + pow((childClinic.coordinate.longitude - coordinate.longitude), 2)) < sqrt(pow((selectedChildClinic.coordinate.latitude - coordinate.latitude), 2) + pow((selectedChildClinic.coordinate.longitude - coordinate.longitude), 2)) {
                
                self.selectedChildClinic = childClinic
            }
        }
    }
    
    // MARK: Popup menu
    private func setupGestures() {
        
        let tapGestureAdult = UITapGestureRecognizer(target: self, action: #selector(tappedAdult))
        tapGestureAdult.numberOfTapsRequired = 1
        chooseAdultClinicButton.addGestureRecognizer(tapGestureAdult)
        let tapGestureChild = UITapGestureRecognizer(target: self, action: #selector(tappedChild))
        tapGestureChild.numberOfTapsRequired = 1
        chooseChildClinicButton.addGestureRecognizer(tapGestureChild)
    }
    
    @objc private func tappedAdult() {
        
        guard let popVC = storyboard?.instantiateViewController(identifier: "popVC") else { return }
        
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.adultClinicLabel
        popOverVC?.sourceRect = CGRect(x: self.adultClinicLabel.bounds.midX, y: self.adultClinicLabel.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 300, height: 250)
        
        (popVC as! PopupTableViewController).delegate = self
                        
        self.present(popVC, animated: true)
    }
    
    @objc private func tappedChild() {
        
        guard let popVC = storyboard?.instantiateViewController(identifier: "popChildVC") else { return }
        
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.childClinicLabel
        popOverVC?.sourceRect = CGRect(x: self.childClinicLabel.bounds.midX, y: self.childClinicLabel.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 300, height: 250)
        
        (popVC as! PopupChildClinicTableViewController).delegate = self
                        
        self.present(popVC, animated: true)
    }
    
    // MARK: Functions related to location
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkAuthorization()
            
        } else {
            
            showAlertLocation(title: NSLocalizedString("Your geolocation service is disabled", comment: ""), message: NSLocalizedString("Do you want to turn it on?", comment: ""), url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
    }
    
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlertLocation(title: NSLocalizedString("You have banned the use of location", comment: ""), message: NSLocalizedString("Do you want to change this?", comment: ""), url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
    
    func showAlertLocation(title:String, message:String?, url:URL?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default) { (alert) in
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    

}

// MARK: Extensions
// MARK: CLLocationManagerDelegate
extension MapViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Clinic else { return nil }
        var viewMarker: MKMarkerAnnotationView
        let idView = "marker"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
            view.annotation = annotation
            viewMarker = view
        } else {
            viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMarker.canShowCallout = true
            viewMarker.calloutOffset = CGPoint(x: 0, y: 6)
            viewMarker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return viewMarker
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let clinic = view.annotation as! Clinic
        if modelClinic.clinics[0].contains(clinic) {
            changeSelectedAdultClinic(clinic: clinic)
        }
        if modelClinic.clinics[1].contains(clinic) {
            changeSelectedChildClinic(clinic: clinic)
        }
    }
}

// MARK: UIPopoverPresentationControllerDelegate
extension MapViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

