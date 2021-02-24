//
//  PostimageVC.swift
//  Fitness
//
//  Created by Namrata Akash on 24/12/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

class PostimageVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var Savebtn:UIButton!
    @IBOutlet weak var selectbtn:UIButton!
    @IBOutlet weak var imageview:UIImageView!
    var selectedimage = UIImage()
    var arrselectedimage = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        clear()
    }
    func clear()
    {
        imageview.image = .none
        
    }
    func SelectImage(astrsourcetype:String)
    {
        let ctrlobj = UIImagePickerController()
        ctrlobj.delegate = self
        ctrlobj.sourceType = .savedPhotosAlbum
        present(ctrlobj, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedimage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageview.image = selectedimage
        dismiss(animated: true, completion: nil)
        self.arrselectedimage.append(selectedimage)
    }

    @IBAction func addbtnaction(_ sender: Any) {
        SelectImage(astrsourcetype: "photo")
    }
    
    @IBAction func savebtnaction(_ sender: Any) {
        
        
        let strimage = Commoncode().createimgbase64(aimg: selectedimage)
        let discriptionpostobj = self.storyboard?.instantiateViewController(withIdentifier: "DiscriptionpostVC") as! DiscriptionpostVC
        discriptionpostobj.imagedata = strimage
        discriptionpostobj.arrimage = arrselectedimage
        print(arrselectedimage)
        self.navigationController?.pushViewController(discriptionpostobj, animated: true)
        
    }
}
