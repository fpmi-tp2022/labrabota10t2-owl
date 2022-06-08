//
//  HospitalsViewController.swift
//  Clinics
//
//  Created by Mac on 6/8/22.
//

import UIKit

class HospitalsViewController: UIViewController {
    
    // MARK: Variables
    var hospital = Hospital(name: "", location: "", departments: [])
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = hospital.name

        self.collectionView.register(UINib(nibName: "HospitalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HospitalCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

}

// MARK: Extensions
// MARK: Collection View
extension HospitalsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hospital.departments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HospitalCollectionViewCell", for: indexPath) as! HospitalCollectionViewCell
        cell.setupCell(department: hospital.departments[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 220)
    }
}
