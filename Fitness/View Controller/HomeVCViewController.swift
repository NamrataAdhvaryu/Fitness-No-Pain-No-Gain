//
//  HomeVCViewController.swift
//  Fitness
//
//  Created by Namrata Akash on 10/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class HomeVCViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    
var arr = ["GYM","ZUMBA","YOGA"]
 var logoImage: [UIImage] = [
     UIImage(named: "GYm.jpeg")!,
     UIImage(named: "ZUMBA.JPEG")!,
     UIImage(named: "YOGA.JPEG")!
 ]
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.delegate = self
        collectionview.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arr.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coll_cell", for: indexPath) as! Cellcollectionview
        cell.lbl.text = arr[indexPath.row]
        cell.imgview.image = logoImage[indexPath.row]
        return cell
     }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
