//
//  HorizontalCalendarController.swift
//  VACalendarExample
//
//  Created by Anton Vodolazkyi on 09.03.18.
//  Copyright © 2018 Anton Vodolazkyi. All rights reserved.
//

import UIKit
import VACalendar

final class HorizontalCalendarController: UIViewController {
    var plistService = PlistFileService.instance
    var showevent = [Subject]()
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
        
//        let dot:(Date,[VADaySupplementary])
//        let dots = [dot]
        
        for subject in showevent
        {
            guard var date = subject.date , let dateend = subject.dateend  else {return}
            //calendarView.setSupplementaries([(date, [VADaySupplementary.bottomDots([UIColor.green])])])
            //calendarView.setSupplementaries([(dateend, [VADaySupplementary.bottomDots([UIColor.red])])])
            
                let calendar2 = Calendar.current
                while date < dateend {
                    date = calendar2.date(byAdding: .day, value: 1, to: date)!
                    for days in subject.dayofweek
                    {
                        print(days,subject.subjectName)
                        print("-----")
                        if (date.weekdayOrdinal == days)
                        {
                            print(subject.subjectName)
                            calendarView.setSupplementaries([(date, [VADaySupplementary.bottomDots([UIColor(red:0.27, green:0.66, blue:0.67, alpha:1.0)])])])
                        }
                    }
                }
            
            
        }
        
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
////                for days in itemsubject.dayofweek
////                {
////                    if (date2.weekdayOrdinal == days)
////                    {
////                        //var subcount = subjectn.count
////                        print(subjectn)
////                        calendarView.setSupplementaries([(date2, [VADaySupplementary.bottomDots([UIColor.magenta,.purple])])])
////                    }
////                }
//            }
//        }
        
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
    
    @IBAction func changeMode(_ sender: Any)
    {
//        calendarView.changeViewType()
        
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
        //getsubjectday(today: dateselect)
        //getevent(today: dateselect)
    }
    
}


