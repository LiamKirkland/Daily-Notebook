//
//  NotesVC.swift
//  DailyNotebook
//
//  Created by  on 11/9/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {
    
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var customImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        customImage.image = imageArray[selectedCell]
        notes.text = eventNotes[selectedCell]
    }
    //make save button actually save.
    
    @IBAction func saveChanges(_ sender: Any) {
        eventNotes[selectedCell] = notes.text
    }
    
    

}
