//
//  ViewController.swift
//  DailyNotebook
//
//  Created by  on 11/6/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit
import CoreData

var image = #imageLiteral(resourceName: "example")

var eventNames: Array = ["Example Event"]
var eventTimes: Array = ["Jan 1, 2017 at 12:00 AM"]
var eventNotes: Array = ["These are your notes."]
var imageArray: Array = [image]

var events: Array = [Event]()

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
    
    let event = Event(context: PersistenceService.context)
    
    let eventImg = UIImagePNGRepresentation(image) as NSData?
//    event.title = "Example Event"
//    event.notes = "These are your notes"
//    event.date = "Jan 1, 2017 at 12:00 AM"
//    event.image = eventImg
//    PersistenceService.saveContext()
//    events.append(event)
//
    override func viewDidLoad() {
        super.viewDidLoad()
        //let newAssignment = Assignment(title: "Hello", notes: "blahblahblah", Date: "Now")
        
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        do{
            let eventList = try PersistenceService.context.fetch(fetchRequest)
            
            
            events = eventList
            
            for event in events {
                if event.title == nil {
                    let myEventIndex = events.index(of: event)!
                    events.remove(at: myEventIndex)
                }
            }
            //self.eventLog.reloadData()
        }catch{
            
        }
            
        eventLog.delegate = self
        eventLog.dataSource = self
        
//        PersistenceService.context.delete(events[events.count - 1])
//        do {
//            try PersistenceService.context.save()
//            eventLog.reloadData()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetch_data()
        
        eventLog?.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(events.count)
        print (events)
        
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
//        var myCell = tableView.dequeueReusableCell(withIdentifier: "myCell")
//        if (myCell == nil)
//        {
//            myCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
//        }
        myCell.textLabel?.text = events[indexPath.row].title
        myCell.detailTextLabel?.text = events[indexPath.row].date
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        selectedCell = indexPath.row
        //add code to NotesVC
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            PersistenceService.context.delete(events[indexPath.row])
            events.remove(at: indexPath.row)
            eventLog.deleteRows(at: [indexPath], with: .fade)
            do {
                try PersistenceService.context.save()
                eventLog.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    
}



