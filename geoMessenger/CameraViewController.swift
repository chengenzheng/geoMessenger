//
//  CameraViewController.swift
//  geoMessenger
//
//  Created by chengen Zheng on 2017/10/14.
//  Copyright © 2017年 chengen Zheng. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgPhoto: UIImageView!
    
    var storageRef: StorageReference!
    func configureStorage() {
        let storageUrl = FirebaseApp.app()?.options.storageBucket
        storageRef = Storage.storage().reference(forURL: "gs://" + storageUrl!)
    }
    
    @IBAction func btnSavePhoto_Tap(_ sender: UIBarButtonItem) {
        let imageData = UIImageJPEGRepresentation(imgPhoto.image!, 0.6)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        let ac = UIAlertController(title: "Photo Saved!", message: "Your photo was saved successfully", preferredStyle:  .alert)
        ac .addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        let guid = "test_id"
        let imagePath = "\(guid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        let metadata = StorageMetadata()
       metadata.contentType = "image/jpeg"
        
        if imageData! == nil{ print("imageData is empty")}
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = storageRef.child(imagePath).putData(imageData!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL
            print(downloadURL)
        }
        
        
        
//        self.storageRef.child(imagePath)
//        .putData(imageData!, metadata: metadata)
//             { [weak self] (metadata, error) in
//          if let error = error {
//                   print("Error uploading: \(error)")
//                  return
//              }
        
 //       }
    }
    
    @IBAction func btnTakePhoto_TouchUpInside(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .camera
            imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnPickPhoto_TouchUpInside(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .photoLibrary
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPhoto.image = selectedImage
        } else {
            print("Something went wrong")
        }
    
    dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
