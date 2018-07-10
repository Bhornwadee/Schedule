//
//  Inforclass.swift
//  calendar2
//
//  Created by WV-MAC on 26/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import Foundation

class Courseclass: NSObject, NSCoding {
    
    
    var subjectName:String?
    var Classtype:String?
    var TimeStart:Date?
    var TimeEnd:Date?
    var Howoftenclass:String?
    var DateStart:Date?
    var DateEnd:Date?
    var Location:String?
    var Instructor:String?
    //var date:Date?
    
    //init(subjectName:String,date:Date)
    init(subjectName:String,Classtype:String,TimeStart:Date,TimeEnd:Date,Howoftenclass:String,DateStart:Date,DateEnd:Date,Location:String,Instructor:String){
        self.subjectName = subjectName
        self.Classtype = Classtype
        self.TimeStart = TimeStart
        self.TimeEnd = TimeEnd
        self.Howoftenclass = Howoftenclass
        self.DateStart = DateStart
        self.DateEnd = DateEnd
        self.Location = Location
        self.Instructor = Instructor
        //self.date = date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(subjectName, forKey: "subjectName")
        aCoder.encode(Classtype, forKey: "Classtype")
        aCoder.encode(TimeStart, forKey: "TimeStart")
        aCoder.encode(TimeEnd, forKey: "TimeEnd")
        aCoder.encode(Howoftenclass, forKey: "Howoftenclass")
        aCoder.encode(DateStart, forKey: "DateStart")
        aCoder.encode(DateEnd, forKey: "DateEnd")
        aCoder.encode(Location, forKey: "Location")
        aCoder.encode(Instructor, forKey: "Instructor")
        //aCoder.encode(date, forKey: "date")
    }
    
    required init?(coder aDecoder: NSCoder) {
        subjectName = aDecoder.decodeObject(forKey: "subjectName") as? String ?? ""
        Classtype = aDecoder.decodeObject(forKey: "Classtype") as? String ?? ""
        TimeStart = aDecoder.decodeObject(forKey: "TimeStart") as? Date ?? nil
        TimeEnd = aDecoder.decodeObject(forKey: "TimeEnd") as? Date ?? nil
        Howoftenclass = aDecoder.decodeObject(forKey: "Howoftenclass") as? String ?? ""
        DateStart = aDecoder.decodeObject(forKey: "DateStart") as? Date ?? nil
        DateEnd = aDecoder.decodeObject(forKey: "DateEnd") as? Date ?? nil
        Location = aDecoder.decodeObject(forKey: "Location") as? String ?? ""
        Instructor = aDecoder.decodeObject(forKey: "Instructor") as? String ?? ""
        //date = aDecoder.decodeObject(forKey: "date") as? Date ?? nil
    }
}

