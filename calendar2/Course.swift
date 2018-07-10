//
//  Course.swift
//  calendar2
//
//  Created by WV-MAC on 25/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

class Course: UIViewController , ColorcollectionviewDelegate{
     var plistService = PlistFileService.instance
    @IBOutlet weak var Coursename: UITextField!
    @IBOutlet weak var coursecolors: UIImageView!
    @IBOutlet weak var coursedate: UILabel!
    @IBOutlet weak var DMYclasseditpicker: UIDatePicker!
    var subject:Subject?
    var editbool:Bool = false
    var ccolor:String?
    var psubjectname:String?
    
    var pdate:Date? //เก็บใน plist
    var date1:Date? //ค่าเดิม
    var date2:Date? //ค่าใหม่
    
    var colorch:String? //รับสีเดิมกรiีไม่เปลียนสี
    var colorpic:String? //รับสีจากการเลือกสรใหม่
    var pcolorcourse:String?//ดึงไปเก็บในplist
    //var coursepic = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DMYclasseditpicker.addTarget(self, action: #selector(self.dmyclassedit(sender:)), for: UIControlEvents.valueChanged)
        guard let ccolor = ccolor else {return}
        coursecolors.image = UIImage(named: ccolor)
       
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        print("set Value.\(subject?.subjectName),\(editbool)")
        //semester = plistService.getAllSubject()
        if editbool == false
        {
            //print(subject)
            guard let subjectname = subject?.subjectName , let datecourse = subject?.date , let coursecolor = subject?.colorimage else {return}
            let deviceLocale = Locale.current.identifier //getเวลาจากเครื่อง
                let formatter = DateFormatter();
                formatter.locale = Locale(identifier: deviceLocale)
                formatter.dateFormat = "dd-MM-yyyy"; //format dmy
                let datecc = formatter.string(from: datecourse)
                //date to string
            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-mm-yyyy" //Your date format
//            dateFormatter.timeZone = TimeZone(abbreviation: "UTC+7") //Current time zone
//            let dateedit = dateFormatter.date(from: datecc) //according to date format your date string
//            print(dateedit ?? "") //Convert String to Date
//            print(datecc)
            
            
            date1 = datecourse
            Coursename.text = subjectname
            coursedate.text = datecc
           self.coursecolors.image = UIImage(named: coursecolor)
            colorch = coursecolor
            editbool = true
            //print("set value")
         
        }
        else
        {
            print("Something")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func dmyclassedit(sender: UIDatePicker)
    {
        let dateformat2 = DateFormatter()
        dateformat2.dateStyle = DateFormatter.Style.medium
        dateformat2.timeStyle = DateFormatter.Style.none
        let strDate2 = dateformat2.string(from: DMYclasseditpicker.date)
        coursedate.text = strDate2
        date2 = DMYclasseditpicker.date
    }
    
    @IBAction func editbtn(_ sender: UIButton)
    {
        psubjectname = Coursename.text
        
        //Check color
        if (colorpic != nil)
        {
            if (colorpic != colorch)
            {
                pcolorcourse = colorpic
            }
            else
            {
                pcolorcourse = colorch
            }
        }
        else
        {
            pcolorcourse = colorch
        }
        
        //Check date
        if (date2 != nil)
        {
            if (date2 != date1)
            {
                pdate = date2
            }
            else
            {
                pdate = date1
            }
        }
        else
        {
            pdate = date1
        }
        print(psubjectname)
        print(pdate)
        print(pcolorcourse)
//        print("print \(date1)")
//        print("print \(date2)")
        print(subject?.id)
        guard let id = subject?.id, let psubjectname = psubjectname , let pdate = pdate ,let pcolorcourse = pcolorcourse else{return}
        plistService.editdata(id: id,subjectName: psubjectname, date: pdate, colorimage: pcolorcourse)
    }
    
    @IBAction func Choosecolor_edit(_ sender: UIButton)
    {
        let colorview = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "colorcollectionview") as! colorcollectionview
        colorview.delegate = self
        self.navigationController?.pushViewController(colorview, animated: true)
    }
    
    func changeBackgroundColor(picture: String)
    {
        coursecolors.image = UIImage(named: picture)
        colorpic = picture
        print("change background color")
        //self.coursedate.text = picture
        
    }
    
    
//    func editchangecolor(subject:Subject)
//    {
////        print(subject.subjectName,subject.date,subject.colorimage)
//        //set ค่า แทน viewappear
//        self.subject = subject
//        guard let subnamecourse = self.subject?.subjectName , let datecourse = self.subject?.date , let ccolor = self.subject?.colorimage  else {return}
//        print(subnamecourse,datecourse,ccolor)
////        let deviceLocale = Locale.current.identifier //getเวลาจากเครื่อง
////        let formatter = DateFormatter();
////        formatter.locale = Locale(identifier: deviceLocale)
////        formatter.dateFormat = "dd-MM-yyyy"; //format dmy
////        let datecc = formatter.string(from: datecourse)
//        //date to string
//
////        print(self.Coursename)
//        //self.Coursename.text = "subnamecourse"
////        self.coursedate.text = datecc
////        coursecolor.image = UIImage(named: ccolor)
////                print(subject.subjectName)
////                print(subject.date)
////                print(subject.colorimage)
//        print("Viewwillappear working")
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
