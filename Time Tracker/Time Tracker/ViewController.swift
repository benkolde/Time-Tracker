//
//  ViewController.swift
//  Time Tracker
//
//  Created by Ben Kolde on 2/22/18.
//  Copyright © 2018 benkolde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sessions = [sessionObject]()
    
    @IBOutlet weak var sessionTimer: UILabel!
    @IBOutlet weak var sessionStartTime: UILabel!
    @IBOutlet weak var sessionStopTime: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    
    @IBOutlet weak var moveToSaveButton: UIButton?
    @IBOutlet weak var discardSession: UIButton?
    
    var totalTime = 0
   
    
    
    
    
    
    
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    
    //time and date stuff
    let date = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()

    // action card
    @IBOutlet weak var actionCard: UIView!
    
   
    
    
    
    @IBAction func startSessionButton(_ sender: UIButton) {
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        //view.backgroundColor = .white
        
        sessionStartTime.text = dateFormatter.string(from: date as Date)
        
        if isTimerRunning == false {
            runTimer()
            sender.setImage(UIImage(named: "stop"), for: UIControlState.normal)
            sender.isHidden = false
            
            
            
        } else if isTimerRunning == true {
            sender.setImage(UIImage(named: "go"), for: UIControlState.normal)
            stopTimer()
            sessionStopTime.text = dateFormatter.string(from: date as Date)
            
            sender.isHidden = true
            moveToSaveButton?.isHidden = false
            discardSession?.isHidden = false
            
            
            
        }
    }
    
    
   
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        
        isTimerRunning = true
    }
    
    func stopTimer() {
        timer.invalidate()
    }

    
    @objc func updateTimer() {
        seconds += 1     //This will add the seconds.
        sessionTimer.text = timeString(time: TimeInterval(seconds))

    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        let totalTimeGetter = Int(time)
        totalTime = totalTimeGetter

        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        moveToSaveButton?.isHidden = true
        discardSession?.isHidden = true
        
//       let decoded = UserDefaults.standard.object(forKey: "sessionArray") as! Data
//       sessions = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [sessionObject]
        

        
        let date = NSDate()
        
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        print(dateFormatter.string(from: date as Date))
        currentDate?.text = dateFormatter.string(from: date as Date)
        
        //actionCard.layer.shadowColor = UIColor.black.cgColor
        //actionCard.layer.shadowOpacity = 0.1
       // actionCard.layer.shadowOffset = CGSize.zero
      //  actionCard.layer.shadowRadius = 25
      //  actionCard.layer.shouldRasterize = true

        
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSaveSegue" {
            let destination = segue.destination as? saveSessionViewController
            
            print(totalTime)

            
            destination?.timerThatWasBroughtOver = sessionTimer.text!
            destination?.startTime = sessionStartTime.text!
            destination?.endTime = sessionStopTime.text!
            destination?.sessionDate = currentDate.text!
            destination?.totalTime = totalTime
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: sessions)
            UserDefaults.standard.set(encodedData, forKey: "sessionArray")
            UserDefaults.standard.synchronize()
            
        }
    }


}

