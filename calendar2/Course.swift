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
    @IBOutlet weak var coursedatestart: UILabel!
    @IBOutlet weak var coursedateend: UILabel!
    @IBOutlet weak var DMYclasseditpicker1: UIDatePicker!
    @IBOutlet weak var DMYclasseditpicker2: UIDatePicker!
     var checkmark = [Subject]()
    var subject:Subject?
    var editbool:Bool = false
    var ccolor:String?
    var psubjectname:String?
    
    var pdate:Date? //เก็บใน plist
    var pdateend:Date? //เก็บใน plist stop
    var date1:Date? //ค่าเดิมstart
    var date2:Date? //ค่าใหม่
    var date4:Date? //ค่าเดิมstop
    var date3:Date? //ค่าใหม่วันสุดท้าย
    
    var colorch:String? //รับสีเดิมกรiีไม่เปลียนสี
    var colorpic:String? //รับสีจากการเลือกสรใหม่
    var pcolorcourse:String?//ดึงไปเก็บในplist
    
    let checkbox = Checkbox(frame: CGRect(x: 50, y: 50, width: 25, height: 25))
    var tickBoxmon:Checkbox!
    var tickBoxtue:Checkbox!
    var tickBoxwed:Checkbox!
    var tickBoxthu:Checkbox!
    var tickBoxfri:Checkbox!
    var tickBoxsat:Checkbox!
    var tickBoxsun:Checkbox!
    //var coursepic = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DMYclasseditpicker1.isHidden = true
        DMYclasseditpicker2.isHidden = true
        DMYclasseditpicker1.addTarget(self, action: #selector(self.dmyclassedit1(sender:)), for: UIControlEvents.valueChanged)
        DMYclasseditpicker2.addTarget(self, action: #selector(self.dmyclassedit2(sender:)), for: UIControlEvents.valueChanged)
        addCheckboxSubviews()
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
            guard let subjectname = subject?.subjectName , let datecourse = subject?.date, let datecourseend = subject?.dateend , let coursecolor = subject?.colorimage else {return}
            let deviceLocale = Locale.current.identifier //getเวลาจากเครื่อง
                let formatter = DateFormatter();
                formatter.locale = Locale(identifier: deviceLocale)
                formatter.dateFormat = "dd-MM-yyyy"; //format dmy
                let datecc = formatter.string(from: datecourse)
                //date to string
            
                let formatter4 = DateFormatter();
                formatter4.locale = Locale(identifier: deviceLocale)
                formatter4.dateFormat = "dd-MM-yyyy"; //format dmy
                let dateee = formatter4.string(from: datecourseend)
            //date to string
            
            
            for selectday in (subject?.dayofweek)!
            {
                //print(selectday)
                switch selectday{
                case 1:
                    print("Sunday")
                    tickBoxsun.isChecked = true
                case 2:
                    print("Monday")
                    tickBoxmon.isChecked = true
                case 3:
                    print("Tuesday")
                    tickBoxtue.isChecked = true
                case 4:
                    print("Wednesday")
                    tickBoxwed.isChecked = true
                case 5:
                    print("Thursday")
                    tickBoxthu.isChecked = true
                case 6:
                    print("Friday")
                    tickBoxfri.isChecked = true
                case 7:
                    print("Saturday")
                    tickBoxsat.isChecked = true
                default:
                    print("day")
                }
            }
            showcheckmark()
            date4 = datecourseend
            date1 = datecourse
            Coursename.text = subjectname
            coursedatestart.text = datecc
            coursedateend.text = dateee
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
        //Check dateend
        if (date3 != nil)
        {
            if (date3 != date4)
            {
                pdateend = date3
            }
            else
            {
                pdateend = date4
            }
        }
        else
        {
            pdateend = date4
        }

        print(psubjectname)
        print(pdate)
        print(pcolorcourse)
//        print("print \(date1)")
//        print("print \(date2)")
        print(subject?.id)
        guard let id = subject?.id, let psubjectname = psubjectname , let pdate = pdate, let pdateend  = pdateend ,let pcolorcourse = pcolorcourse else{return}
        let day = selectday()
        print(day)
        plistService.editdata(id: id,subjectName: psubjectname, date: pdate, dateend: pdateend ,colorimage: pcolorcourse, dayofweek: day)
    }
    
    
    @IBAction func dmystart_btn(_ sender: UIButton)
    {
        if  DMYclasseditpicker1.isHidden
        {
            DMYclasseditpicker1.isHidden = false
            DMYclasseditpicker2.isHidden = true
        }
    }
    
    @objc func dmyclassedit1(sender: UIDatePicker)
    {
        let dateformat2 = DateFormatter()
        dateformat2.dateStyle = DateFormatter.Style.short
        dateformat2.timeStyle = DateFormatter.Style.none
        let strDate = dateformat2.string(from: DMYclasseditpicker1.date)
        coursedatestart.text = strDate
        date2 = DMYclasseditpicker1.date
    }
    @IBAction func dmyend_btn(_ sender: UIButton)
    {
        if  DMYclasseditpicker2.isHidden
        {
            DMYclasseditpicker2.isHidden = false
            DMYclasseditpicker1.isHidden = true
        }
    }
    
    @objc func dmyclassedit2(sender: UIDatePicker)
    {
        let dateformat3 = DateFormatter()
        dateformat3.dateStyle = DateFormatter.Style.short
        dateformat3.timeStyle = DateFormatter.Style.none
        let stpDate = dateformat3.string(from: DMYclasseditpicker2.date)
        coursedateend.text = stpDate
        //print("stpdate : .\(stpDate)")
        date3 = DMYclasseditpicker2.date
    }
    
    func showcheckmark()
    {
        for itemcheck in checkmark
        {
            print(itemcheck.dayofweek.count)
        }
    }
    
    func addCheckboxSubviews() {
        
        // tick
        tickBoxmon = Checkbox(frame: CGRect(x: 162, y: 370, width: 25, height: 25))
        tickBoxmon.borderStyle = .square
        tickBoxmon.checkmarkStyle = .tick
        tickBoxmon.checkmarkSize = 0.7
        //tickBoxmon.tag = 1 //id
        view.addSubview(tickBoxmon!)
        
        tickBoxtue = Checkbox(frame: CGRect(x: 199, y: 370, width: 25, height: 25))
        tickBoxtue.borderStyle = .square
        tickBoxtue.checkmarkStyle = .tick
        tickBoxtue.checkmarkSize = 0.7
        view.addSubview(tickBoxtue!)
        
        tickBoxwed = Checkbox(frame: CGRect(x: 237, y: 370, width: 25, height: 25))
        tickBoxwed.borderStyle = .square
        tickBoxwed.checkmarkStyle = .tick
        tickBoxwed.checkmarkSize = 0.7
        view.addSubview(tickBoxwed)
        
        tickBoxthu = Checkbox(frame: CGRect(x: 275, y: 370, width: 25, height: 25))
        tickBoxthu.borderStyle = .square
        tickBoxthu.checkmarkStyle = .tick
        tickBoxthu.checkmarkSize = 0.7
        view.addSubview(tickBoxthu)
        
        tickBoxfri = Checkbox(frame: CGRect(x: 314, y: 370, width: 25, height: 25))
        tickBoxfri.borderStyle = .square
        tickBoxfri.checkmarkStyle = .tick
        tickBoxfri.checkmarkSize = 0.7
        view.addSubview(tickBoxfri)
        
        tickBoxsat = Checkbox(frame: CGRect(x: 354, y: 370, width: 25, height: 25))
        tickBoxsat.borderStyle = .square
        tickBoxsat.checkmarkStyle = .tick
        tickBoxsat.checkmarkSize = 0.7
        view.addSubview(tickBoxsat)
        
        tickBoxsun = Checkbox(frame: CGRect(x: 125, y: 370, width: 25, height: 25))
        tickBoxsun.borderStyle = .square
        tickBoxsun.checkmarkStyle = .tick
        tickBoxsun.checkmarkSize = 0.7
        view.addSubview(tickBoxsun)
        
    }
    
    func selectday() -> [Int]
    {
        var days = [Int]()
        if tickBoxsun.isChecked == true
        {
            days.append(1)
        }
        if tickBoxmon.isChecked == true
        {
            days.append(2)
        }
        if tickBoxtue.isChecked == true
        {
            days.append(3)
        }
        if tickBoxwed.isChecked == true
        {
            days.append(4)
        }
        if tickBoxthu.isChecked == true
        {
            days.append(5)
        }
        if tickBoxfri.isChecked == true
        {
            days.append(6)
        }
        if tickBoxsat.isChecked == true
        {
            days.append(7)
        }
        return days
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
