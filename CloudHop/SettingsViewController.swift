//
//  SettingsViewController.swift
//  CloudHop
//
//  Created by Carlos Chavez on 4/14/22.
//

import UIKit
import AlamofireImage
import FirebaseStorage


class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let storageRef = Storage.storage().reference(forURL: "gs://cptravelapp.appspot.com")
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage?.layer.cornerRadius = (userImage?.frame.size.width ?? 0.0) / 2
        userImage?.clipsToBounds = true
        userImage?.layer.borderWidth = 3.0
        userImage?.layer.borderColor = UIColor.white.cgColor

        UserUtil.getProfilePicture(email: UserUtil.userEmail) { img in
            let pfpUrl = URL(string: img)!
            self.userImage.af.setImage(withURL: pfpUrl)
        }
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func clickOutsideText(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 200, height: 200)
        let scaledImage = image.af.imageScaled(to: size)
        userImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        if usernameField.text != "" {
            UserUtil.setUsername(email: UserUtil.userEmail, username: usernameField.text!)
        }
        
        guard let imageData = userImage.image!.jpegData(compressionQuality: 0.4) else { return }
        let profileStorageRef = storageRef.child("profile").child(UserUtil.userEmail)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        profileStorageRef.putData(imageData, metadata: metadata) { storageMeta, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            profileStorageRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    print(metaImageUrl)
                    UserUtil.setProfilePicture(email: UserUtil.userEmail, img: metaImageUrl)
                }
            }
            
        }
        
        
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
