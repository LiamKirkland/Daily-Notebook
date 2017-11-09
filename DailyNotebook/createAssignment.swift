//
//  createAssignment.swift
//  DailyNotebook
//
//  Created by  on 11/8/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit

class createAssignment: UIViewController {
    
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventNote: UITextField!
    @IBOutlet weak var createAssignment: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
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
            
            let alert = UIAlertController(title: "Event Created", message: "Add another or tap 'back'.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    

}
