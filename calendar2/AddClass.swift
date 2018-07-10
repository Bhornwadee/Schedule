//
//  AddClass.swift
//  calendar2
//
//  Created by WV-MAC on 26/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

class AddClass: UIViewController {

    @IBOutlet weak var coursename: UILabel!
    @IBOutlet weak var classType: UILabel!
    @IBOutlet weak var T1Class: UILabel!
    @IBOutlet weak var T2Class: UILabel!
    @IBOutlet weak var T1Classpicker: UIDatePicker!
    @IBOutlet weak var T2Classpicker: UIDatePicker!
    @IBOutlet weak var howoften: UILabel!
    @IBOutlet weak var Sun_Btn: UIButton!
    @IBOutlet weak var Mon_Btn: UIButton!
    @IBOutlet weak var Tue_Btn: UIButton!
    @IBOutlet weak var Wed_Btn: UIButton!
    @IBOutlet weak var Thu_Btn: UIButton!
    @IBOutlet weak var Fri_Btn: UIButton!
    @IBOutlet weak var Sat_Btn: UIButton!
    @IBOutlet weak var DMY1Class: UILabel!
    @IBOutlet weak var DMY2Class: UILabel!
    @IBOutlet weak var DMY1Classpicker: UIDatePicker!
    @IBOutlet weak var DMY2Classpicker: UIDatePicker!
    @IBOutlet weak var locations: UITextField!
    @IBOutlet weak var instructor: UITextField!
    var coursename1:String!
    var Days = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
       self.coursename.text = self.coursename1
        T1Classpicker.addTarget(self, action: #selector(self.T1class(sender:)), for: UIControlEvents.valueChanged)
        T2Classpicker.addTarget(self, action: #selector(self.T2class(sender:)), for: UIControlEvents.valueChanged)
        T1Classpicker.isHidden = true
        T2Classpicker.isHidden = true
        DMY1Classpicker.isHidden = true
        DMY2Classpicker.isHidden = true
        DMY1Classpicker.addTarget(self, action: #selector(self.DMY1class(sender:)), for: UIControlEvents.valueChanged)
        DMY2Classpicker.addTarget(self, action: #selector(self.DMY2class(sender:)), for: UIControlEvents.valueChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func T1Class_Btn(_ sender: UIButton)
    {
        if  T1Classpicker.isHidden
        {
            T1Classpicker.isHidden = false
            T2Classpicker.isHidden = true
        }
    }
    @objc func T1class(sender: UIDatePicker)
    {
        let T1classformat = DateFormatter()
        T1classformat.dateStyle = DateFormatter.Style.none
        T1classformat.timeStyle = DateFormatter.Style.short
        let strTime = T1classformat.string(from: T1Classpicker.date)
        T1Class.text = strTime
    }
    @IBAction func T2Class_Btn(_ sender: UIButton)
    {
        if  T2Classpicker.isHidden
        {
            T2Classpicker.isHidden = false
            T1Classpicker.isHidden = true
        }
    }
    @objc func T2class(sender: UIDatePicker)
    {
        let T2classformat = DateFormatter()
        T2classformat.dateStyle = DateFormatter.Style.none
        T2classformat.timeStyle = DateFormatter.Style.short
        let stpTime = T2classformat.string(from: T2Classpicker.date)
        T2Class.text = stpTime
    }
    @IBAction func DMY1Class_Btn(_ sender: UIButton)
    {
        if  DMY1Classpicker.isHidden
        {
            DMY1Classpicker.isHidden = false
            DMY2Classpicker.isHidden = true
        }
    }
    @objc func DMY1class(sender: UIDatePicker)
    {
        let D1classformat = DateFormatter()
        D1classformat.dateStyle = DateFormatter.Style.medium
        D1classformat.timeStyle = DateFormatter.Style.none
        let strDay = D1classformat.string(from: DMY1Classpicker.date)
       DMY1Class.text = strDay
    }
    @IBAction func DMY2Class_Btn(_ sender: UIButton)
    {
        if  DMY2Classpicker.isHidden
        {
            DMY2Classpicker.isHidden = false
            DMY1Classpicker.isHidden = true
        }
    }
    @objc func DMY2class(sender: UIDatePicker)
    {
        let D2classformat = DateFormatter()
        D2classformat.dateStyle = DateFormatter.Style.medium
        D2classformat.timeStyle = DateFormatter.Style.none
        let stpDay = D2classformat.string(from: DMY2Classpicker.date)
        DMY2Class.text = stpDay
    }
    @IBAction func Day_Btntap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        //เกบชื่อวันใน dayname
        guard let txt = sender.titleLabel,let dayName = txt.text else // กัน error
        {
            return
        }
        print(dayName)
        Dayarr(sender: dayName)
    }
    
    func Dayarr (sender:String) //เกบค่า day
    {
        if let index = Days.index(of: sender) //check ว่าค่าที่เข้ามา;้ำมั้ย
        {
            Days.remove(at: index) //;้ำลบออก
        }
        else
        {
            Days.append(sender)
        }
        print(Days)
    }
    @IBAction func unWindClasstypes(segue: UIStoryboardSegue)
    {
        if let vc = segue.source as? UITableViewController
        {
            let index = vc.tableView.indexPathForSelectedRow //` check ว่าuserกดrowไหนของtable
            let cell = vc.tableView.cellForRow(at: index!) //ดึงcellออกมา
            let msg = cell?.textLabel?.text //เกบข้อมุลใน msg
            print(msg!)
            self.classType.text = msg
        }
    }
    @IBAction func unWindClassHowOften(segue: UIStoryboardSegue)
    {
        if let vc = segue.source as? UITableViewController
        {
            let index = vc.tableView.indexPathForSelectedRow //` check ว่าuserกดrowไหนของtable
            let cell = vc.tableView.cellForRow(at: index!) //ดึงcellออกมา
            let msg = cell?.textLabel?.text //เกบข้อมุลใน msg
            print(msg!)
            self.howoften.text = msg
        }
    }
    
    @IBAction func Addclass_Btn(_ sender: UIButton)
    {
        let ClassView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Detailclass") as! Detailclass
        ClassView.coursenamesh1 = self.coursename.text
        ClassView.classTypesh1 = self.classType.text
        
        let T1classformat = DateFormatter()
        T1classformat.dateStyle = DateFormatter.Style.none
        T1classformat.timeStyle = DateFormatter.Style.short
        let strTime = T1classformat.string(from: T1Classpicker.date)
        T1Class.text = strTime
        ClassView.T1Classsh1 = self.T1Class.text
        
        let T2classformat = DateFormatter()
        T2classformat.dateStyle = DateFormatter.Style.none
        T2classformat.timeStyle = DateFormatter.Style.short
        let stpTime = T2classformat.string(from: T2Classpicker.date)
        T2Class.text = stpTime
        ClassView.T2Classsh1 = self.T2Class.text
        
        let D1classformat = DateFormatter()
        D1classformat.dateStyle = DateFormatter.Style.medium
        D1classformat.timeStyle = DateFormatter.Style.none
        let strDay = D1classformat.string(from: DMY1Classpicker.date)
        DMY1Class.text = strDay
        ClassView.DMY1Classsh1 = self.DMY1Class.text
        
        let D2classformat = DateFormatter()
        D2classformat.dateStyle = DateFormatter.Style.medium
        D2classformat.timeStyle = DateFormatter.Style.none
        let stpDay = D2classformat.string(from: DMY2Classpicker.date)
        DMY2Class.text = stpDay
        ClassView.DMY2Classsh1 = self.DMY2Class.text
        
        ClassView.howoftensh1 = self.howoften.text
        
        ClassView.Locationssh1 = self.locations.text
        
        ClassView.instructorsh1 = self.instructor.text
        
        self.present(ClassView, animated: true, completion: nil)
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
