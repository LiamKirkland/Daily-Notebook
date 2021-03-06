//
//  createAssignment.swift
//  DailyNotebook
//
//  Created by  on 11/8/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit
import CoreData

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

class createAssignment: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventNote: UITextView!
    @IBOutlet weak var createAssignment: UIButton!
    @IBOutlet weak var imagePicker: UIImageView!
    
    let imagePick = UIImagePickerController()
    var pickedImg: UIImage = #imageLiteral(resourceName: "blank")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        eventTitle.delegate = self
        eventNote.delegate = self
        imagePick.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        eventTitle.resignFirstResponder()
        //eventNote.resignFirstResponder()
        return true
    }
    func textView(_ eventNote: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            eventNote.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ eventNote: UITextView) {
        DispatchQueue.main.async {
            eventNote.selectAll(nil)
        }
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
            pickedImg = pickedImage
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
                
            }
            
            let event = Event(context: PersistenceService.context)
            let eventImg = UIImagePNGRepresentation(pickedImg) as NSData?
            event.title = eventTitle.text
            event.notes = eventNote.text
            event.date = formatter.string(from: currentDateTime)
            event.image = eventImg
            PersistenceService.saveContext()
            events.append(event)
            
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
