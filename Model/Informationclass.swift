//
//  Informationclass.swift
//  podtest
//
//  Created by WV-MAC on 21/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import Foundation

class Subject: NSObject, NSCoding{
    
    var id:String?
    var subjectName:String?
    var date:Date?
    var dateend:Date?
    var colorimage:String?
    var dayofweek = [Int]()
//    var classType:String? //1
//    var timeStart:Date?
//    var timeEnd:Date?
//    var howoftenclass:String?
//    var dateStart:Date?
//    var dateEnd:Date?
//    var location:String?
//    var instructor:String?

    //init(subjectName:String,date:Date)
    init(subjectName:String,date:Date,dateend: Date ,colorimage:String,dayofweek:[Int]){
        id = UUID().uuidString
        self.subjectName = subjectName
        self.date = date
        self.dateend = dateend
        self.colorimage = colorimage
        self.dayofweek = dayofweek

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(subjectName, forKey: "subjectName")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(dateend,forKey: "dateend")
        aCoder.encode(colorimage, forKey: "colorimage")
        aCoder.encode(dayofweek, forKey: "dayofweek")

        

    }
    
    required init?(coder aDecoder: NSCoder) {
        subjectName = aDecoder.decodeObject(forKey: "subjectName") as? String ?? ""
        date = aDecoder.decodeObject(forKey: "date") as? Date ?? nil
        dateend = aDecoder.decodeObject(forKey: "dateend") as? Date ?? nil
        colorimage = aDecoder.decodeObject(forKey: "colorimage") as? String ?? ""
        dayofweek = aDecoder.decodeObject(forKey: "dayofweek") as! [Int]


    }
}

