//
//  saveSessionViewController.swift
//  Time Tracker
//
//  Created by Ben Kolde on 2/22/18.
//  Copyright © 2018 benkolde. All rights reserved.
//

import UIKit

class saveSessionViewController: ViewController {
    
    @IBOutlet weak var sessionStartSaved: UILabel!
    @IBOutlet weak var sessionStopSaved: UILabel!
    @IBOutlet weak var sessionTitle: UITextField?
    @IBOutlet weak var carriedOverTimer: UILabel!
    @IBOutlet weak var sessionDescription: UITextField?
    @IBOutlet weak var saveDate: UILabel!
    
    let userDefaults = UserDefaults.standard

    
    var timerThatWasBroughtOver = "default"
    var startTime = "default"
    var endTime = "default"
    var sessionDate = "default"
    var something = 0
    var sessionArray = [sessionObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        carriedOverTimer.text = timerThatWasBroughtOver
        sessionStartSaved.text = startTime
        sessionStopSaved.text = endTime
        saveDate.text = sessionDate
        something = totalTime
        
        print(totalTime)
        
        
        let decoded = userDefaults.object(forKey: "sessionArray") as! Data
        
        sessionArray = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [sessionObject]
        
        print("hello")
        
        sessionTitle?.becomeFirstResponder()
        
        func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
            self.sessionTitle?.resignFirstResponder()
            self.sessionDescription?.resignFirstResponder()
        }
        
       
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToTimesheet" {
            let destination = segue.destination as? timeSheetViewController

            var newSession = sessionObject(sessionTitle: (sessionTitle?.text)!, sessionDescription: (sessionDescription?.text)!, sessionDate: sessionDate, sessionStart: startTime, sessionEnd: endTime, sessionLength: timerThatWasBroughtOver, objectTotalTime: totalTime)
            
            print(totalTime)
            
            
            
//            func archiveSession(sessionArray:[sessionObject]) -> NSData {
//                let archivedObject = NSKeyedArchiver.archivedData(withRootObject: sessionArray as NSArray)
//                return archivedObject as NSData
//            }
//
//            let sessionData = archiveSession(sessionArray: [newSession])
//
//            if let unarchivedSession = NSKeyedUnarchiver.unarchiveObject(with: sessionData as Data) as? [sessionObject] {
//                for newSession in unarchivedSession {
//                    print("\(newSession.sessionTitle), you have been unarchived")
//                }
//            } else {
//                print("Failed to unarchive people")
//            }
//
//            let UserDefaultsSessionKey = "sessionKey"
//            func saveSession(sessionArray: [sessionObject]) {
//                let archivedObject = archiveSession(sessionArray: [newSession])
//                let defaults = UserDefaults.standard
//                defaults.set(archivedObject, forKey: UserDefaultsSessionKey)
//                defaults.synchronize()
//            }

            
            
            
            sessionArray.append(newSession)
            
            print(sessionArray.count)

            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: sessionArray)
            userDefaults.set(encodedData, forKey: "sessionArray")
            userDefaults.synchronize()
            print("there")
            
            
 

            destination?.sessionArray = sessionArray
            
            

        }
    }
    
    
}


