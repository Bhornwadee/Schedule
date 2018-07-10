//
//  AddCourse.swift
//  calendar2
//
//  Created by WV-MAC on 22/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

class AddCourse: UIViewController , ColorcollectionviewDelegate {
    var picname = "blue"
    var plistService = PlistFileService.instance
    @IBOutlet weak var NameCourse: UITextField!
    @IBOutlet weak var DMYClassstart: UILabel!
    @IBOutlet weak var DMYclassend: UILabel!
    @IBOutlet weak var DMYClasspickerstart: UIDatePicker!
    @IBOutlet weak var DMYClasspickerend: UIDatePicker!
    @IBOutlet weak var colorimage: UIImageView!
    let checkbox = Checkbox(frame: CGRect(x: 50, y: 50, width: 25, height: 25))
    var tickBoxmon:Checkbox!
    var tickBoxtue:Checkbox!
    var tickBoxwed:Checkbox!
    var tickBoxthu:Checkbox!
    var tickBoxfri:Checkbox!
    var tickBoxsat:Checkbox!
    var tickBoxsun:Checkbox!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  plistService.loadDataFromPlist()
        //print("total \(plistService.loadDataFromPlist())")
        DMYClasspickerstart.isHidden = true
        DMYClasspickerend.isHidden = true
         DMYClasspickerstart.addTarget(self, action: #selector(self.dmystart(sender:)), for: UIControlEvents.valueChanged) //3
         DMYClasspickerend.addTarget(self, action: #selector(self.dmyend(sender:)), for: UIControlEvents.valueChanged)
        addCheckboxSubviews()
        colorimage.image = UIImage(named: picname)
        // Do any additional setup after loading the view.
    }

   
    @IBAction func DMYstartbtn(_ sender: UIButton)
    {
        if  DMYClasspickerstart.isHidden
        {
            DMYClasspickerstart.isHidden = false
            DMYClasspickerend.isHidden = true
        }
    }
    @objc func dmystart(sender: UIDatePicker)
    {
        let dateformat = DateFormatter()
        dateformat.dateStyle = DateFormatter.Style.medium
        dateformat.timeStyle = DateFormatter.Style.none
        let strDate = dateformat.string(from: DMYClasspickerstart.date)
        DMYClassstart.text = strDate
    }
    
    @IBAction func DMYendbtn(_ sender: UIButton)
    {
        if  DMYClasspickerend.isHidden
        {
            DMYClasspickerend.isHidden = false
            DMYClasspickerstart.isHidden = true
        }
    }
   
    @objc func dmyend(sender: UIDatePicker)
    {
        let dateformat2 = DateFormatter()
        dateformat2.dateStyle = DateFormatter.Style.medium
        dateformat2.timeStyle = DateFormatter.Style.none
        let stpDate = dateformat2.string(from: DMYClasspickerend.date)
        DMYclassend.text = stpDate
    }
    
    @IBAction func SaveCourse_Btn(_ sender: UIButton)
    {
        guard  let text = NameCourse.text else { return }
        let date1 = DMYClasspickerstart.date
        let date2 = DMYClasspickerend.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "mm-dd-yyyy" //Your date format
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
//        guard let datee = dateFormatter.date(from: DMYClass.text!) else{return}//according to date format your date string
//        print(datee ?? "") //Convert String to Date
//        plistService.addSubject(subjectName: text, date: datee, classType: "" ,timeStart: "",timeEnd: "",howoftenclass: "",dateStart: "",dateEnd: "",location: "",instructor: "")
//        print("\(text) + \(datee)")
       // let succeed = (favoriteGooglelocations as NSDictionary).writeToFile(path, atomically: true)
    
        //let subject = Subject(subjectName: text,date: DMYClasspicker.date,colorimage:picname)
        

        //print(Days)
        //print(tickBoxmon.isChecked,tickBoxtue.isChecked,tickBoxwed.isChecked,tickBoxthu.isChecked,tickBoxfri.isChecked,tickBoxsat.isChecked,tickBoxsun.isChecked)
        
            //print(Days)
        //print(Days.count)
        let day = selectday()
        print(day)
      plistService.addSubject(subjectName: text, date: DMYClasspickerstart.date, dateend: DMYClasspickerend.date ,colorimage: picname,dayofweek: day)
       
         //print(plistService.loadDataFromPlist().count)
    }
    
    @IBAction func choosecolor_btn(_ sender: UIButton)
    {
        let nextViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "colorcollectionview") as! colorcollectionview
        nextViewController.delegate = self
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func changeBackgroundColor(picture: String)
    {
//        let myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
//        colorimage.layer.borderWidth = 2
//        colorimage.layer.borderColor = myColor.cgColor
        colorimage.image = UIImage(named: picture)
        picname = picture
    }
    
//    @IBAction func ReadCourse_Btn(_ sender: UIButton)
//    {
//        plistService.getAllSubject()
//        print(plistService.getAllSubject())
//    } //ปุ่มread
    
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
    
//    @IBAction func confirmday(_ sender: UIButton)
//    {
//        if tickBoxsun.isChecked == true {
//            print("Sunday")
//            Days[0] = 1
//            Days.append(Days[0])
//            print(Days[0])
//        }
//        if tickBoxmon.isChecked == true{
//            print("Monday")
//            Days[1] = 2
//            Days.append(Days[1])
//            print(Days[1])
//        }
//        if tickBoxtue.isChecked == true {
//            print("Tuesday")
//            Days[2] = 3
//            Days.append(Days[2])
//            print(Days[2])
//        }
//        if tickBoxwed.isChecked == true {
//            print("Wednesday")
//            Days[3] = 4
//            Days.append(Days[3])
//            print(Days[3])
//        }
//        if tickBoxthu.isChecked == true {
//            print("Thursday")
//            Days[4] = 5
//            Days.append(Days[4])
//            print(Days[4])
//        }
//        if tickBoxfri.isChecked == true {
//            print("Friday")
//            Days[5] = 6
//            Days.append(Days[5])
//            print(Days[5])
//        }
//        if tickBoxsat.isChecked == true {
//            print("Saturday")
//            Days[6] = 7
//            Days.append(Days[6])
//            print(Days[6])
//        }
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
