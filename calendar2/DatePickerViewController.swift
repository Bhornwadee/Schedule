//
//  ViewController.swift
//  JBDatePicker
//
//  Created by Joost van Breukelen on 09-10-16.
//  Copyright © 2016 Joost van Breukelen. All rights reserved.
//

import UIKit
import JBDatePicker
import SwiftDate

extension Date
{
    func stripped() -> Date?{
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        let strippedDate = calendar.date(from: components)
        return strippedDate
    }
    var weekdayOrdinal: Int {
        return Calendar.current.component(.weekday, from: self)
    }

}

class DatePickerViewController: UIViewController, JBDatePickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var datePickerView: JBDatePickerView!
    
    @IBOutlet weak var tableviewsh: UITableView!
    var plistService = PlistFileService.instance
    var showsubject = [Subject]()
    var dateToSelect: Date!
    var todayclass = [Subject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        plistService.setDefaultloadData()
        tableviewsh.delegate = self
        tableviewsh.dataSource = self
         tableviewsh.separatorStyle = .none
        //print(showsubject.count)
        // Do any additional setup after loading the view, typically from a nib.
        datePickerView.delegate = self
        
        //get presented month
        self.navigationItem.title = datePickerView.presentedMonthView?.monthDescription
        //
        //        remove hairline under navigationbar
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "GreenPixel"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage(named: "GreenPixel")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshdata()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    func  refreshdata()
    {
        showsubject = plistService.getAllSubject()
        filtertodayclass(today: Date())
        //getDayOfWeek()
    }
    
    // MARK: - JBDatePickerViewDelegate
    
    //    func didSelectDay(_ dayView: JBDatePickerDayView) {
    //
    ////        self.performSegue(withIdentifier: "unwindFromDatepicker", sender: self)
    //        print("date selected: \(String(describing: dayView.date))")
    //    }
    
    func didSelectDay(_ dayView: JBDatePickerDayView)
    {
        //self.performSegue(withIdentifier: "unwindFromDatepicker", sender: self)
        guard let date = dayView.date else {return}
        print("didselect")
        //let deviceLocale = Locale.current.identifier //getเวลาจากเครื่อง
        //let formatter = DateFormatter();
        //formatter.locale = Locale(identifier: deviceLocale)
        //formatter.dateFormat = "dd-MM-yyyy"; //format dmy
        //formatter.dateFormat = "EEEE, MMMM dd, yyyy" //Day of week
        //let dateString = formatter.string(from: date)
        filtertodayclass(today: date)
        //print("date pick \(dateString)")
        //.dateString = dateString
        //print(dateString)
        //self.dismiss(animated: true, completion: nil)
    }
    
//    func filtertodayclass(today:Date)
//    {
//        //let today = today
//        print("today \(today.weekdayOrdinal)")
//        todayclass.removeAll()
//        for item in showsubject
//        {
//            guard let subject = item.date else{return}
//            if(subject.weekdayOrdinal == today.weekdayOrdinal)
//            {
//             //   print(item.subjectName)
//                todayclass.append(item)
//            }
//        }
//        // print(todayclass)
//        tableviewsh.reloadData()
//    }

        func filtertodayclass(today:Date)
        {
            //let today = today
            //print("today \(today.weekdayOrdinal)")
            todayclass.removeAll()
            // print(todayclass)

            for item in showsubject
            {
                guard let datestart = item.date, let dateend = item.dateend else{return}
                let subname = item.subjectName
        //print(today.weekdayOrdinal,item.dayofweek)
                
                let dayy = datestart >= today || today < dateend
                print(subname)
                print(dayy)
                
                //compare two date more or less
//                if datestart.compare(dateend) == .orderedAscending
//                {
//                    print("first date is smaller than second date")
//                }
//                else if datestart.compare(dateend) == .orderedDescending
//                {
//                    print("first date is grater than second date")
//                }
//                else { print("the both are equal") }
//                print(datestart >= today,today < dateend)
//                if (datestart >= today || today < dateend)
//                {
//                for days in item.dayofweek
//                {
//                    if (today.weekdayOrdinal == days)
//                    {
//                        //print("found")
//                        todayclass.append(item)
//                    }
//                 }
//              }
            }
            tableviewsh.reloadData()
        }

    func didPresentOtherMonth(_ monthView: JBDatePickerMonthView) {
        self.navigationItem.title = datePickerView.presentedMonthView.monthDescription
    }
    
    func shouldAllowSelectionOfDay(_ date: Date?) -> Bool {
        
        guard let date = date else {return true}
        let comparison = NSCalendar.current.compare(date, to: Date().stripped()!, toGranularity: .day)
        
        if comparison == .orderedAscending
        {
            return false
        }
        return true
        
    }
    
    var colorForUnavaibleDay: UIColor {
        return .blue
    }
    
    var dateToShow: Date {
        
        if let date = dateToSelect {
            return date
        }
        else{
            return Date()
        }
    }
    
    var weekDaysViewHeightRatio: CGFloat {
        return 0.1
    }
    

    @IBAction func loadNextMonth(_ sender: UIBarButtonItem) {
        datePickerView.loadNextView()
    }

    @IBAction func loadPreviousMonth(_ sender: UIBarButtonItem) {
        datePickerView.loadPreviousView()
    }
    

    @IBAction func dismissDatePicker(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todayclass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.rowHeight = 75
        let subject = todayclass[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellviewsh",for: indexPath) as! tableviewcustomcell
        guard let showsub = todayclass[indexPath.row].subjectName else{return cell}
        guard let imagename = subject.colorimage,let images = UIImage(named:imagename), let coursetext = todayclass[indexPath.row].subjectName else {return cell}
        cell.courseimg1.image = images
        cell.courselbl1.text = coursetext
         cell.selectionStyle = .none
        //cell.backgroundColor = UIColor(red:0.93, green:0.94, blue:0.94, alpha:1.0)
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let startVC = segue.destination as? StartViewController
        {
            if let selectedDate = datePickerView.selectedDateView.date
            {
                startVC.date = selectedDate
            }
        }
        
    }
    
}



