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

        notes.delegate = self
        customImage.image = imageArray[selectedCell]
        notes.text = eventNotes[selectedCell]
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
        eventNotes[selectedCell] = notes.text
    }
    
    

}
