//
//  ViewController.swift
//  DailyNotebook
//
//  Created by  on 11/6/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit

var image = #imageLiteral(resourceName: "blank")

var eventNames: Array = ["Example Event"]
var eventTimes: Array = ["Jan 1, 2017 at 12:00 AM"]
var eventNotes: Array = ["These are your notes."]
var imageArray: Array = [image]

var selectedCell: Int = 0

extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}

extension UITableViewCell {
    
    var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var eventLog: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newAssignment = Assignment(title: "Hello", notes: "blahblahblah", Date: "Now")
        
        eventLog.delegate = self
        eventLog.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetch_data()
        
        eventLog?.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        selectedCell = indexPath.row
        //add code to NotesVC
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print(indexPath.row)
            eventNames.remove(at: indexPath.row)
            eventTimes.remove(at: indexPath.row)
            eventNotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}

struct Assignment {
    var title: String
    var notes: String
    var Date: String
}

