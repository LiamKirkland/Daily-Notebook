//
//  NotesVC.swift
//  DailyNotebook
//
//  Created by  on 11/9/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit

class NotesVC: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var customImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if events[selectedCell].image == nil{
            
        }else{
        
        let imagePt = UIImage(data: (events[selectedCell].image as! NSData) as Data)
        customImage.image = imagePt 
        notes.text = events[selectedCell].notes
        notes.delegate = self
        }
    }
    //make save button actually save.
    
    func textView(_ notes: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            notes.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ notes: UITextView) {
        DispatchQueue.main.async {
            notes.selectAll(nil)
        }
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        events[selectedCell].notes = notes.text
        PersistenceService.saveContext()
        
        let alert = UIAlertController(title: "Notes Saved", message: "Your notes have been successfully saved.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    

}
