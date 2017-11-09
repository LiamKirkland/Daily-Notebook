//
//  ViewController.swift
//  DailyNotebook
//
//  Created by  on 11/6/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit

var eventNames: Array = ["Example Event"]
var eventTimes: Array = ["Jan 1, 2017 at 12:00 AM"]
var eventNotes: Array = ["These are your notes."]

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBAction func createAssignment(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newAssignment = Assignment(title: "Hello", notes: "blahblahblah", Date: "Now")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return eventNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var myCell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        if (myCell == nil)
        {
            myCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        }
        myCell?.textLabel?.text = eventNames[indexPath.row]
        myCell?.detailTextLabel?.text = eventTimes[indexPath.row]
        
        return myCell!
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }


}

struct Assignment {
    var title: String
    var notes: String
    var Date: String
}

