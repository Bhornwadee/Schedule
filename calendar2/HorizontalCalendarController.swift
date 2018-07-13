//
//  HorizontalCalendarController.swift
//  VACalendarExample
//
//  Created by Anton Vodolazkyi on 09.03.18.
//  Copyright © 2018 Anton Vodolazkyi. All rights reserved.
//

import UIKit
import VACalendar
extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
    
final class HorizontalCalendarController: UIViewController {
    var plistService = PlistFileService.instance
    let colorarray = [UIColor.black,.blue,.green,.purple] //130761
    let colorarray2 = [UIColor.red,.darkGray,.lightGray,.blue] //130761
    var supplementaries = [Supplementaries]() //เก็บ class
    var showevent = [Subject]()
    let aqua:UIColor = UIColor(red:0.52, green:0.81, blue:0.82, alpha:1.0)
    let yellow:UIColor = UIColor(red:0.99, green:0.69, blue:0.32, alpha:1.0)
    let red:UIColor = UIColor(red:0.84, green:0.24, blue:0.38, alpha:1.0)
    let cressgreen:UIColor = UIColor(red:0.74, green:0.66, blue:0.35, alpha:1.0)
    let green:UIColor = UIColor(red:0.56, green:0.67, blue:0.39, alpha:1.0)
    let purple:UIColor = UIColor(red:0.72, green:0.42, blue:0.62, alpha:1.0)
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView! {
        didSet {
            let appereance = VAMonthHeaderViewAppearance(
                previousButtonImage:UIImage(named: " Messages - Up Arrow-1")! ,
                nextButtonImage:UIImage(named: " Messages - Up Arrow")!,
                dateFormat: "LLLL"
            )
            monthHeaderView.delegate = self
            monthHeaderView.appearance = appereance
        }
    }
    
    @IBOutlet weak var weekDaysView: VAWeekDaysView! {
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
   
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    var calendarView: VACalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        plistService.getAllSubject()
        showevent = plistService.getAllSubject()
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .multi
        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        
        let dot2 = (date:Date().yesterday,colors:[VADaySupplementary.bottomDots(colorarray2)])
        var dots = [dot2]

        for list in showevent
        {
            guard let name = list.subjectName ,var start = list.date,let end = list.dateend else {return}
            if name == "America"
            {
                print("AME")
                let calendar2 = Calendar.current
                while start < end {
                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
                  
                   // print (dateindex)
                    for days in list.dayofweek
                    {
                        if (start.weekdayOrdinal == days)
                        {
                            //calendarView.setSupplementaries([(start, [VADaySupplementary.bottomDots([aqua])])])
                            if let dateindex = Search(datestring: start.description) {
                                
                                //print (dateindex)
                                print("found.\(dateindex)")
                                supplementaries[dateindex].subjects.append("America")
                                supplementaries[dateindex].color.append(aqua)
                            }
                            else{
                                let supplement = Supplementaries()
                                supplement.id = start.description // key
                                supplement.fordate = start
                                supplement.color.append(aqua)
                                supplementaries.append(supplement)
                                print("create new model")
                            }
                        }
                    }
                }
            }
                else if name == "Brazil"
                {
                    let calendar2 = Calendar.current
                    while start < end {
                        start = calendar2.date(byAdding: .day, value: 1, to: start)!
            
                        for days in list.dayofweek
                        {
                            if (start.weekdayOrdinal == days)
                            {
                                //calendarView.setSupplementaries([(start, [VADaySupplementary.bottomDots([yellow])])])
                                if let dateindex = Search(datestring: start.description) {
                                    
                                    //print (dateindex)
                                    print("found.\(dateindex)")
                                    supplementaries[dateindex].subjects.append("Brazil")
                                    supplementaries[dateindex].color.append(yellow)
                                }
                                else{
                                    let supplement = Supplementaries()
                                    supplement.id = start.description // key
                                    supplement.fordate = start
                                    supplement.color.append(yellow)
                                    supplementaries.append(supplement)
                                    
                                    print("create new model")
                                }
                            }
                        }
                }
            }
            else if name == "Canada"
            {
                let calendar2 = Calendar.current
                while start < end {
                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
                    for days in list.dayofweek
                    {
                        if (start.weekdayOrdinal == days)
                        {
                            calendarView.setSupplementaries([(start, [VADaySupplementary.bottomDots([red])])])
                        }
                    }
                }
            }
            else if name == "Denmark"
            {
                let calendar2 = Calendar.current
                while start < end {
                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
                    for days in list.dayofweek
                    {
                        if (start.weekdayOrdinal == days)
                        {
                            calendarView.setSupplementaries([(start, [VADaySupplementary.bottomDots([cressgreen])])])
                        }
                    }
                }
            }
            else if name == "England"
            {
                let calendar2 = Calendar.current
                while start < end {
                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
                    for days in list.dayofweek
                    {
                        if (start.weekdayOrdinal == days)
                        {
                            calendarView.setSupplementaries([(start, [VADaySupplementary.bottomDots([green])])])
                        }
                    }
                }
            }
            else if name == "France"
            {
                let calendar2 = Calendar.current
                while start < end {
                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
                    for days in list.dayofweek
                    {
                        if (start.weekdayOrdinal == days)
                        {
                         //   print(calendarView.)
                            calendarView.setSupplementaries([(start, [VADaySupplementary.bottomDots([purple])])])
                        }
                    }
                }
            }
            let dot = (date:Date(),colors:[VADaySupplementary.bottomDots(colorarray)])
            //
            var dots = [dot]
            //            //showcodeui.append(codeui)
            //            let dot = (date:subject.date,colors:[VADaySupplementary.bottomDots(showcodeui)]) //130761
            //            dots.append(dot as! (date: Date, colors: [VADaySupplementary]))//130761
            //            calendarView.setSupplementaries(dots)//130761
            for supplement in supplementaries
            {
                print(supplement.fordate,supplement.subjects.count)
                let dot = (date:supplement.fordate,colors:[VADaySupplementary.bottomDots(supplement.color)])
                dots.append(dot as! (date: Date, colors: [VADaySupplementary]))
                
            }
            calendarView.setSupplementaries(dots)//130761
        }
        
//        for subject in showevent
//        {
//            var showcodeui = [UIColor]()
//            guard var date = subject.date , let dateend = subject.dateend , let subjectn = subject.subjectName  else {return}
//              var arraychoosecolor = ["blackblue","blue","Marina","Aqua","lightblue","brown","goldearth","cressgreen","green","lemongrass","suaterne","yellow","red","purple","greypink"]
////            for icolor in arraychoosecolor
////            {  //var codeui:UIColor!
//////                if subject.colorimage == icolor
//////                {
////////                    if icolor == "blackblue"
////////                    {
////////                        let codeui = UIColor(red:0.37, green:0.53, blue:0.62, alpha:1.0)
////////                        showcodeui.append(codeui)
////////                        print(subjectn,codeui)
////////                    }
////////                    if icolor == "blue"
////////                    {
////////                         let codeui = UIColor(red:0.07, green:0.51, blue:0.67, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "Marina"
////////                    {
////////                        let codeui = UIColor(red:0.31, green:0.52, blue:0.75, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "Aqua"
////////                    {
////////                        let codeui = UIColor(red:0.52, green:0.81, blue:0.82, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "lightblue"
////////                    {
////////                        let codeui = UIColor(red:0.64, green:0.83, blue:0.87, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "brown"
////////                    {
////////                        let codeui = UIColor(red:0.77, green:0.56, blue:0.44, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "goldearth"
////////                    {
////////                        let codeui = UIColor(red:0.87, green:0.61, blue:0.45, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "crossgreen"
////////                    {
////////                        let codeui = UIColor(red:0.74, green:0.66, blue:0.35, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "green"
////////                    {
////////                        let codeui = UIColor(red:0.56, green:0.67, blue:0.39, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "lemongrass"
////////                    {
////////                        let codeui = UIColor(red:0.86, green:0.83, blue:0.61, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "suaterne"
////////                    {
////////                        let codeui = UIColor(red:0.77, green:0.71, blue:0.37, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "yellow"
////////                    {
////////                        let codeui = UIColor(red:0.99, green:0.69, blue:0.32, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "red"
////////                    {
////////                        let codeui = UIColor(red:0.84, green:0.24, blue:0.38, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "purple"
////////                    {
////////                        let codeui = UIColor(red:0.72, green:0.42, blue:0.62, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
////////                    if icolor == "greypink"
////////                    {
////////                        let codeui = UIColor(red:0.92, green:0.81, blue:0.78, alpha:1.0)
////////                        print(subjectn,codeui)
////////                        showcodeui.append(codeui)
////////                    }
//////
//////            //calendarView.setSupplementaries([(date, [VADaySupplementary.bottomDots([UIColor.green])])])
//////            //calendarView.setSupplementaries([(dateend, [VADaySupplementary.bottomDots([UIColor.red])])])
//////
            

////
//////            let dot = (date:Date(),colors:[VADaySupplementary.bottomDots(colorarray)])
////
//////            let dots = [dot,dot2]
////            //showcodeui.append(codeui)
////            let dot = (date:subject.date,colors:[VADaySupplementary.bottomDots(showcodeui)]) //130761
////            dots.append(dot as! (date: Date, colors: [VADaySupplementary]))//130761
////            calendarView.setSupplementaries(dots)//130761
////
////                }
//
//            //var dots = [dot]
//            }
        
    //comment
//        let date2 = Date()
//        let calendar2 = Calendar.current
//        let hour2 = calendar2.component(.hour, from: date2)
//        let minutes2 = calendar2.component(.minute, from: date2)
//        for itemsubject in showevent
//        {
//            guard let datestart = itemsubject.date, let dateend = itemsubject.dateend, let subjectn = itemsubject.subjectName else {return}
//            if(date2.isInRange(date: datestart , and: dateend))
//            {
//                calendarView.setSupplementaries([(date2, [VADaySupplementary.bottomDots([UIColor.magenta,.purple])])])
//                for days in itemsubject.dayofweek
//                {
//                    if (date2.weekdayOrdinal == days)
//                    {
//                        //var subcount = subjectn.count
//                        print(subjectn)
//                        calendarView.setSupplementaries([(date2, [VADaySupplementary.bottomDots([UIColor.magenta,.purple])])])
//                    }
//                }
//            }
//        }
        //comment
        
        //แสดงจุดวันที่มีวิชา
    
//        for subject in showevent
//        {
//            guard var date = subject.date , let dateend = subject.dateend  else {return}
//            //calendarView.setSupplementaries([(date, [VADaySupplementary.bottomDots([UIColor.green])])])
//            //calendarView.setSupplementaries([(dateend, [VADaySupplementary.bottomDots([UIColor.red])])])
//
//            let calendar2 = Calendar.current
//            while date < dateend {
//                date = calendar2.date(byAdding: .day, value: 1, to: date)!
//                for days in subject.dayofweek
//                {
//                    print(days,subject.subjectName)
//                    print("-----")
//                    if (date.weekdayOrdinal == days)
//                    {
//                        print(subject.subjectName)
//                        calendarView.setSupplementaries([(date, [VADaySupplementary.bottomDots([UIColor(red:0.27, green:0.66, blue:0.67, alpha:1.0)])])])
//                    }
//                }
//            }
         //แสดงจุดวันที่มีวิชา
        
        
        //กำหนดค่าtoday -> ^ up
        
        //show dot color and given date
//        calendarView.setSupplementaries([
//            (Date().addingTimeInterval(-(60 * 60 * 70)), [VADaySupplementary.bottomDots([.red, .magenta])]),
//            (Date().addingTimeInterval((60 * 60 * 110)), [VADaySupplementary.bottomDots([.red])]),
//            (Date().addingTimeInterval((60 * 60 * 370)), [VADaySupplementary.bottomDots([.blue, .darkGray])]),
//            (Date().addingTimeInterval((60 * 60 * 430)), [VADaySupplementary.bottomDots([.orange, .purple, .cyan])])
//            ])//dot in date

            
            view.addSubview(calendarView)
}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: view.frame.width,
                height: view.frame.height * 0.6
            )
            calendarView.setup()
        }
        
    }
    
    func Search(datestring:String) -> Int? //search
    {
        let item = supplementaries.index(where: {$0.id == datestring})
       return item
    }
    
    @IBAction func changeMode(_ sender: Any)
    {
//        calendarView.changeViewType()
    }
    
    func subjectday(today:Date)
    {
        for item in showevent
        {
            guard let datestart = item.date, let dateend = item.dateend, let subjectn = item.subjectName else {return}
                        if(today.isInRange(date: datestart , and: dateend))
                        {
                            for days in item.dayofweek
                            {
                                if (today.weekdayOrdinal == days)
                                {
                                    //var subcount = subjectn.count
                                    print(subjectn)
                                }
                            }
                        }
        }
    }
    
//    func getsubjectday(today: Date)
//    {
//        for itemsubject in showevent
//        {
//            guard let datestart = itemsubject.date, let dateend = itemsubject.dateend, let subjectn = itemsubject.subjectName else {return}
//             if(today.isInRange(date: datestart , and: dateend))
//             {
//                for days in itemsubject.dayofweek
//                {
//                    if (today.weekdayOrdinal == days)
//                    {
//                        //var subcount = subjectn.count
//
//                        print(subjectn)
//                    }
//                }
//             }
//        }
//    }
    
//    func getevent(today: Date)
//    {
//        for item in showevent
//        {
//            guard let datestart = item.date, let dateend = item.dateend, let subjectn = item.subjectName else {return}
//
//            //print(datestart,dateend,subjectn)
//
//            if(today.isInRange(date: datestart , and: dateend))
//            {
//                for days in item.dayofweek
//                {
//                    if (today.weekdayOrdinal == days)
//                    {
//                        //print("found")
//                        calendarView.setSupplementaries([(today, [VADaySupplementary.bottomDots([UIColor.blue,.red])])])
//                    }
//                }
//            }
//        }
//    }
    }


extension HorizontalCalendarController: VAMonthHeaderViewDelegate {
    
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
}

extension HorizontalCalendarController: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return .black
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
}

extension HorizontalCalendarController: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return .red //color select day
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
}

extension HorizontalCalendarController: VACalendarViewDelegate {
    
    func selectedDates(_ dates: [Date]) {
        //calendarView.startDate = dates.last ?? Date()
        guard let dateselect = dates.last else {return}
        //calendarView.setSupplementaries([(dateselect, [VADaySupplementary.bottomDots([UIColor.blue,.white,.red])])])
        print(dateselect)
        //subjectday(today:dateselect)
        //getsubjectday(today: dateselect)
        //getevent(today: dateselect)
    }
    
}


