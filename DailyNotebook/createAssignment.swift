//
//  createAssignment.swift
//  DailyNotebook
//
//  Created by  on 11/8/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class createAssignment: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventNote: UITextView!
    @IBOutlet weak var createAssignment: UIButton!
    @IBOutlet weak var imagePicker: UIImageView!
    
    let imagePick = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        imagePick.delegate = self
    }
    
    @IBAction func loadImage(_ sender: UIButton) {
        
        imagePick.allowsEditing = false
        imagePick.sourceType = .photoLibrary
        
        present(imagePick, animated: true, completion: nil)
    }
    @IBAction func takeImage(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePick.allowsEditing = false
            imagePick.sourceType = .camera
            
            present(imagePick, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "No Camera", message: "The camera on your phone either doesn't exist or is not available, please use photo library.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicker.contentMode = .scaleAspectFit
            imagePicker.image = pickedImage
            imageArray.append(pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
   
    
    //work on image selector
    @IBAction func createAssignment(_ sender: Any) {
        if(eventTitle.text == "" || eventNote.text == ""){
            let alert = UIAlertController(title: "Empty Field(s)", message: "Please make sure the event title and notes are filled out.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let currentDateTime = Date()
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .medium
            
            eventNames.append(eventTitle.text!)
            eventNotes.append(eventNote.text!)
            eventTimes.append(formatter.string(from: currentDateTime))
            if imagePicker.image == nil {
                imageArray.append(#imageLiteral(resourceName: "blank"))
            }
            
            let alert = UIAlertController(title: "Event Created", message: "Add another or tap Back.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            eventTitle.text = ""
            eventNote.text = ""
            imagePicker.image = nil
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    

}
