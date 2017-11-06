//
//  ViewController.swift
//  DailyNotebook
//
//  Created by  on 11/6/17.
//  Copyright © 2017 Leems Games. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var eventNames: Array = ["Example Event"]
    var eventTimes: Array = [""]
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }


}

