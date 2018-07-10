//
//  RWPlist.swift
//  podtest
//
//  Created by WV-MAC on 21/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import Foundation

class PlistFileClass: NSObject {
    static let instance = PlistFileClass() //singleton
    var courseclass = [Courseclass]()
    private let plistFileCourseClassName = "courseclass"
    
    override init(){
        super.init()
        print("document file path：\(documentsDirectory())")
        print("Data file path：\(dataFilePath())")
    }
    
    //save data
    func saveDataToPlist() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(courseclass, forKey: "classList")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    //read data
    func loadDataFromPlist() {
        let path = self.dataFilePath()
        let defaultManager = FileManager()
        if defaultManager.fileExists(atPath: path)
        {
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            courseclass = unarchiver.decodeObject(forKey: "classList") as! Array
            unarchiver.finishDecoding()
        }
    }
    
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        return documentsDirectory
    }
    
    func dataFilePath ()->String{
        return self.documentsDirectory().appendingFormat("/\(plistFileCourseClassName).plist")
    }
}


