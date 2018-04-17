//
//  sessionObject.swift
//  Time Tracker
//
//  Created by Ben Kolde on 2/22/18.
//  Copyright © 2018 benkolde. All rights reserved.
//

import UIKit

class sessionObject: NSObject, NSCoding  {
   
    
    var sessionTitle: String
    var sessionDescription: String
    var sessionDate: String
    var sessionStart: String
    var sessionEnd: String
    var sessionLength: String
    var objectTotalTime: Int

    
    // This lets the object know that there are actually things in it when it goes
    init(sessionTitle: String, sessionDescription: String, sessionDate: String, sessionStart: String, sessionEnd: String, sessionLength: String, objectTotalTime: Int) {
        self.sessionTitle = sessionTitle
        self.sessionDescription = sessionDescription
        self.sessionDate = sessionDate
        self.sessionStart = sessionStart
        self.sessionEnd = sessionEnd
        self.sessionLength = sessionLength
        self.objectTotalTime = objectTotalTime
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sessionTitle, forKey: "sessionTitle")
        aCoder.encode(sessionDescription, forKey: "sessionDescription")
        aCoder.encode(sessionDate, forKey: "sessionDate")
        aCoder.encode(sessionStart, forKey: "sessionStart")
        aCoder.encode(sessionEnd, forKey: "sessionEnd")
        aCoder.encode(sessionLength, forKey: "sessionLength")
        aCoder.encode(objectTotalTime, forKey:"objectTotalTime")
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let sessionTitle = aDecoder.decodeObject(forKey: "sessionTitle") as! String
        let sessionDescription = aDecoder.decodeObject(forKey: "sessionDescription") as! String
        let sessionDate = aDecoder.decodeObject(forKey: "sessionDate") as! String
        let sessionStart = aDecoder.decodeObject(forKey: "sessionStart") as! String
        let sessionEnd = aDecoder.decodeObject(forKey: "sessionEnd") as! String
        let sessionLength = aDecoder.decodeObject(forKey: "sessionLength") as! String
        let objectTotalTime = aDecoder.decodeInteger(forKey: "objectTotalTime")
        
        self.init(sessionTitle: sessionTitle, sessionDescription: sessionDescription, sessionDate: sessionDate, sessionStart: sessionStart, sessionEnd: sessionEnd, sessionLength: sessionLength, objectTotalTime: objectTotalTime)
    }
    
    
}
