//
//  timeSheetViewController.swift
//  Time Tracker
//
//  Created by Ben Kolde on 2/22/18.
//  Copyright © 2018 benkolde. All rights reserved.
//

import UIKit

class sessionTableCell: UITableViewCell {
    @IBOutlet weak var sessionTableTitle: UILabel!
    @IBOutlet weak var sessionTableDate: UILabel!
    @IBOutlet weak var sessionTableDescription: UILabel!
    @IBOutlet weak var sessionTableLength: UILabel!
}

class timeSheetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleTotal: UILabel!
    
    @IBOutlet weak var sessionTable: UITableView!
    var totalTime = 0
    
    @IBAction func newTotalButton(_ sender: Any) {
        
        
        var totalString = ""
        
        var sessionStr = totalArray.reduce(0, +)
        
            let hours = Int(sessionStr) / 3600
            let minutes = Int(sessionStr) / 60 % 60
            let seconds = Int(sessionStr) % 60
            
            totalString = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
        
        let alert = UIAlertController(title: "Total Time", message: String(describing: totalString), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .cancel , handler: nil))
    
        let errorAlert = UIAlertController(title: "Total Time", message: "Select some sessions to get a total", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Got it!", style: .cancel , handler: nil))
        
        if totalArray.count == 0 {
            self.present(errorAlert, animated: true)
        } else if totalArray.count > 0 {
            self.present(alert, animated: true)
        }
    }
    
    
    var timeSheet = sessionTableCell()
    
    //var sessions = [sessionObject]()
    
    var tableTimer = ""
    var tableTitle = ""
    
    var sessionArray = [sessionObject]()
    var totalArray = [Int]()
    
    
    var userDefaults = UserDefaults.standard

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionArray.count
    }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell") as! sessionTableCell
    
    
       cell.sessionTableTitle?.text = sessionArray[indexPath.row].sessionTitle
       cell.sessionTableDate.text = sessionArray[indexPath.row].sessionDate
       cell.sessionTableLength.text = sessionArray[indexPath.row].sessionLength
       cell.sessionTableDescription?.text = sessionArray[indexPath.row].sessionDescription

        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.sessionArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: sessionArray)
            
            
            userDefaults.set(encodedData, forKey: "sessionArray")
            
            userDefaults.synchronize()
            
            print(sessionArray.count)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = sessionTable.cellForRow(at: indexPath)
        let selectedRows = sessionArray[indexPath.row].objectTotalTime
        totalArray.append(selectedRows)
        titleTotal.text! = String(totalArray.count) + " Sessions Selected"
        if totalArray.count == 0 {
            titleTotal.text = "Timesheet"
        }

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? sessionTableCell
        
        for (index,value) in totalArray.enumerated() {
            if value == sessionArray[indexPath.row].objectTotalTime {
                totalArray.remove(at:index)
                titleTotal.text! = String(totalArray.count) + " Sessions Selected"
                if totalArray.count == 0 {
                    titleTotal.text = "Timesheet"
                }

            }
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        print("there")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sessionTable.delegate = self
        sessionTable.dataSource = self
      
        let decoded = userDefaults.object(forKey: "sessionArray") as! Data
        sessionArray = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [sessionObject]
        sessionTable.reloadData()
        
        print(sessionArray.count)
        
        
        
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goBackToSessions" {
            let destination = segue.destination as? ViewController
            
            destination?.sessions = sessionArray
            
        }
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
}


