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
        let day = selectday()
        print(day)
      plistService.addSubject(subjectName: text, date: DMYClasspickerstart.date, dateend: DMYClasspickerend.date ,colorimage: picname,dayofweek: day)
    }
    
    @IBAction func choosecolor_btn(_ sender: UIButton)
    {
        let nextViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "colorcollectionview") as! colorcollectionview
        nextViewController.delegate = self
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func changeBackgroundColor(picture: String)
    {
        colorimage.image = UIImage(named: picture)
        picname = picture
    }

    func addCheckboxSubviews() {
        
        // tick
        tickBoxmon = Checkbox(frame: CGRect(x: 162, y: 370, width: 25, height: 25))
        tickBoxmon.borderStyle = .square
        tickBoxmon.checkmarkStyle = .tick
        tickBoxmon.checkmarkSize = 0.7
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
