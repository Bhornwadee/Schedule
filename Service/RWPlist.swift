//
//  RWPlist.swift
//  podtest
//
//  Created by WV-MAC on 21/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import Foundation

class PlistFileService {
    
    static let instance = PlistFileService()
    private var semesters = [Subject]()
    private let plistFileName = "myData"

    
    private init() {
        print("Singleton initialized")
        semesters = getAllSubject()
    }
    
    func getAllSubject() -> [Subject]{ //call to show instead semester because private
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("/\(plistFileName).plist")
        print(path)
         //3 บรรทัดบนเป็นการทำ navigate
        let myPlist = NSArray(contentsOfFile: path)
        
        guard let root = myPlist as [AnyObject]? else{ return semesters }
        
        semesters.removeAll()
        for item in root{
            guard let subjectName = item["name"] as? String,let date = item["date"] as? Date, let dateend = item["dateend"] as? Date ,let colorimage = item["colorimage"] as? String, let dayofweek = item["dayofweek"] as? [Int] else{ return semesters }
            //print("name \(subjectName)")
            let subject = Subject(subjectName: subjectName, date: date,dateend: dateend,colorimage: colorimage,dayofweek: dayofweek)//7
            semesters.append(subject)
            
        }
        return semesters
    }
    func addSubject(subjectName:String,date:Date,dateend: Date,colorimage:String,dayofweek:[Int]) {
        let filepath = applicationDocumentsDirectory().appending("/\(plistFileName).plist")
        let physics = Subject(subjectName: subjectName, date: date, dateend: dateend ,colorimage: colorimage,dayofweek: dayofweek)//6
        semesters = getAllSubject()
        semesters.append(physics)
        let saveData = NSMutableArray()
        for subject in semesters {
            var dictionary = [String:AnyObject]()
            dictionary["id"] = subject.id as AnyObject
            dictionary["name"] = subject.subjectName as AnyObject
            dictionary["date"] = subject.date as AnyObject
            dictionary["dateend"] = subject.dateend as AnyObject
            dictionary["colorimage"] = subject.colorimage as AnyObject
             dictionary["dayofweek"] = subject.dayofweek as AnyObject
//            dictionary["classType"] = subject.classType as AnyObject //5
//            dictionary["timeStart"] = subject.timeStart as AnyObject
//            dictionary["timeEnd"] = subject.timeEnd as AnyObject
//            dictionary["howoftenclass"] = subject.howoftenclass as AnyObject
//            dictionary["dateStart"] = subject.dateStart as AnyObject
//            dictionary["dateEnd"] = subject.dateEnd as AnyObject
//            dictionary["location"] = subject.location as AnyObject
//            dictionary["instructor"] = subject.instructor as AnyObject
            saveData.add(dictionary)
        }
        let success = saveData.write(toFile: filepath, atomically: true)
        print(success)
    }
    
    func Search(subjectname:String) //searchหาแล้วลบแล้วบันทึก
    {
        if let i = semesters.index(where: { $0.subjectName == subjectname })
        {
            guard let deldatap = semesters[i].subjectName else {return}
            print(deldatap)
            print(i)
            semesters.remove(at: i)
            print(semesters.count)
        }
        let filepath = applicationDocumentsDirectory().appending("/\(plistFileName).plist")
        let saveData = NSMutableArray()
        for subject in semesters {
            var dictionary = [String:AnyObject]()
            dictionary["name"] = subject.subjectName as AnyObject
            dictionary["date"] = subject.date as AnyObject
            dictionary["dateend"] = subject.dateend as AnyObject
            dictionary["colorimage"] = subject.colorimage as AnyObject
            saveData.add(dictionary)
        }
        let success = saveData.write(toFile: filepath, atomically: true)
        print(success)
        //print(semesters)
        
    }
    
    func editdata(id:String,subjectName:String,date:Date,colorimage:String)
    {
        if let index = semesters.index(where: { $0.id == id })
        {
           let subject = semesters[index]
            print("old name.\(subject.subjectName)")
            print("new name.\(subjectName)")
            subject.subjectName = subjectName
            subject.date = date
            subject.colorimage = colorimage
            
        }
        let filepath = applicationDocumentsDirectory().appending("/\(plistFileName).plist")
        let saveData = NSMutableArray()
        for subject in semesters {
            var dictionary = [String:AnyObject]()
            dictionary["name"] = subject.subjectName as AnyObject
            dictionary["date"] = subject.date as AnyObject
            dictionary["dateend"] = subject.dateend as AnyObject
            dictionary["colorimage"] = subject.colorimage as AnyObject
            saveData.add(dictionary)
        }
        let success = saveData.write(toFile: filepath, atomically: true)
        print(success)
    }
    
    private func applicationDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let basePath = paths.first ?? ""
        return basePath
    }
    
    func setDefaultloadData() { //set default to plist
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("/\(plistFileName).plist")
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)){
            if let bundlePath = Bundle.main.path(forResource: plistFileName, ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle file myData.plist is -> \(String(describing: result))")
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                }catch{
                    print("copy failure.")
                }
            }else{
                print("file myData.plist not found.")
            }
        }else{
            print("file myData.plist already exits at path.")
        }
        
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("load myData.plist is ->\(String(describing: resultDictionary))")
    }
    
}
