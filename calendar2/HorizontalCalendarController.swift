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
    let colorarray = [UIColor]() //130761
    let colorarray2 = [UIColor.red,.darkGray,.lightGray,.blue] //130761
    var supplementaries = [Supplementaries]() //เก็บ class
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
        //plistService.getAllSubject()
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
        
        //let dot2 = (date:Date().yesterday,colors:[VADaySupplementary.bottomDots(colorarray2)])

        
        //160761
        for list in showevent
        {
            showsubjectevent(subject: list)
            //guard let name = list.subjectName ,var start = list.date,let end = list.dateend , let color = list.colorimage else {return}

//            if name == "America"
//            {
//                let calendar2 = Calendar.current
//                while start < end {
//                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                    let subjectColor = colorEvent(namecolor: color)
//                    for days in list.dayofweek
//                    {
//                        if (start.weekdayOrdinal == days)
//                        {
//                            if let dateindex = Search(datestring: start.description) {
//                                supplementaries[dateindex].subjects.append("America")
//                                supplementaries[dateindex].color.append(subjectColor)
//
//                            }
//                            else{
//                                let supplement = Supplementaries()
//                                supplement.id = start.description // key
//                                supplement.fordate = start
//                                supplement.color.append(subjectColor) //อันเจอก่อนขึ้นสีก่อน
//                                supplementaries.append(supplement) //ไม่เจอก็แอดเข้าไปก่อนรอบนึงจากนั้นมันจะโชว์
//                            }
//                        }
//                    }
//                }
//            }
//                else if name == "Brazil"
//                {
//                    let calendar2 = Calendar.current
//                    while start < end {
//                        start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                        let subjectColor = colorEvent(namecolor: color)
//                        for days in list.dayofweek
//                        {
//                            if (start.weekdayOrdinal == days)
//                            {
//                                if let dateindex = Search(datestring: start.description) {
//                                    supplementaries[dateindex].subjects.append("Brazil")
//                                    supplementaries[dateindex].color.append(subjectColor)
//
//                                }
//                                else{
//                                    let supplement = Supplementaries()
//                                    supplement.id = start.description // key
//                                    supplement.fordate = start
//                                    supplement.color.append(subjectColor)
//                                    supplementaries.append(supplement)
//                                }
//                            }
//                        }
//                }
//            }
//            else if name == "Canada"
//            {
//                let calendar2 = Calendar.current
//                while start < end {
//                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                    let subjectColor = colorEvent(namecolor: color)
//                    for days in list.dayofweek
//                    {
//                        if (start.weekdayOrdinal == days)
//                        {
//                            if let dateindex = Search(datestring: start.description) {
//                                supplementaries[dateindex].subjects.append("Canada")
//                                supplementaries[dateindex].color.append(subjectColor)
//
//                            }
//                            else{
//                                let supplement = Supplementaries()
//                                supplement.id = start.description // key
//                                supplement.fordate = start
//                                supplement.color.append(subjectColor)
//                                supplementaries.append(supplement)
//                            }
//                        }
//                    }
//                }
//            }
//            else if name == "Denmark"
//            {
//                let calendar2 = Calendar.current
//                while start < end {
//                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                    let subjectColor = colorEvent(namecolor: color)
//                    for days in list.dayofweek
//                    {
//                        if (start.weekdayOrdinal == days)
//                        {
//                            if let dateindex = Search(datestring: start.description) {
//                                supplementaries[dateindex].subjects.append("Denmark")
//                                supplementaries[dateindex].color.append(subjectColor)
//                            }
//                            else{
//                                let supplement = Supplementaries()
//                                supplement.id = start.description // key
//                                supplement.fordate = start
//                                supplement.color.append(subjectColor)
//                                supplementaries.append(supplement)
//                            }
//                        }
//                    }
//                }
//            }
//            else if name == "England"
//            {
//                let calendar2 = Calendar.current
//                while start < end {
//                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                    let subjectColor = colorEvent(namecolor: color)
//                    for days in list.dayofweek
//                    {
//                        if (start.weekdayOrdinal == days)
//                        {
//                            if let dateindex = Search(datestring: start.description) {
//                                supplementaries[dateindex].subjects.append("England")
//                                supplementaries[dateindex].color.append(subjectColor)
//
//                            }
//                            else{
//                                let supplement = Supplementaries()
//                                supplement.id = start.description // key
//                                supplement.fordate = start
//                                supplement.color.append(subjectColor)
//                                supplementaries.append(supplement)
//                            }
//                        }
//                    }
//                }
//            }
//            else if name == "France"
//            {
//                let calendar2 = Calendar.current
//                while start < end {
//                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                    let subjectColor = colorEvent(namecolor: color)
//                    for days in list.dayofweek
//                    {
//                        if (start.weekdayOrdinal == days)
//                        {
//                            if let dateindex = Search(datestring: start.description) {
//                                supplementaries[dateindex].subjects.append("France")
//                                supplementaries[dateindex].color.append(subjectColor)
//                            }
//                            else{
//                                let supplement = Supplementaries()
//                                supplement.id = start.description // key
//                                supplement.fordate = start
//                                supplement.color.append(subjectColor)
//                                supplementaries.append(supplement)
//                            }
//                        }
//                    }
//                }
//            }
//            else if name == "Croatia"
//            {
//                let calendar2 = Calendar.current
//                while start < end {
//                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                    let subjectColor = colorEvent(namecolor: color)
//                    for days in list.dayofweek
//                    {
//                        if (start.weekdayOrdinal == days)
//                        {
//                            if let dateindex = Search(datestring: start.description) {
//                                supplementaries[dateindex].subjects.append("Croatia")
//                                supplementaries[dateindex].color.append(subjectColor)
//                            }
//                            else{
//                                let supplement = Supplementaries()
//                                supplement.id = start.description // key
//                                supplement.fordate = start
//                                supplement.color.append(subjectColor)
//                                supplementaries.append(supplement)
//                            }
//                        }
//                    }
//                }
//            }
//           if name == "Russia"
//            {
//                let calendar2 = Calendar.current
//                while start < end {
//                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                    let subjectColor = colorEvent(namecolor: color)
//                    for days in list.dayofweek
//                    {
//                        if (start.weekdayOrdinal == days)
//                        {
//                            print("search key.\(start.description)",Search(datestring: start.description))
//
//                            if let dateindex = Search(datestring: "\(start.day)") {
//                                supplementaries[dateindex].subjects.append("Russia")
//                                supplementaries[dateindex].color.append(subjectColor)
//                                //print("Append.\(name)")
//                            }
//                            else{
//                                let supplement = Supplementaries()
//                                print(start.description)
//                                supplement.id = "\(start.day)" // key
//                                print("\(supplement.id).\(name)")
//                                supplement.fordate = start
//                                supplement.color.append(subjectColor)
//                                supplementaries.append(supplement)
//                                //print("found first time.\(name)")
//                            }
//                        }
//                    }
//                }
//            }
//            else if name == "Italy"
//            {
//                //print(supplementaries.count)
//                let calendar2 = Calendar.current
//                while start < end {
//                    start = calendar2.date(byAdding: .day, value: 1, to: start)!
//                    print(start.day,"day")
//                    let subjectColor = colorEvent(namecolor: color)
//                    for days in list.dayofweek
//                    {
//                        if (start.weekdayOrdinal == days)
//                        {
//                            //print(supplementaries.first?.id,start.description,supplementaries.first?.id == start.description)
//
//                            if let dateindex = Search(datestring: "\(start.day)") {
//                                supplementaries[dateindex].subjects.append("Italy")
//                                supplementaries[dateindex].color.append(subjectColor)
//                                //print("Append.\(name)")
//                            }
//                            else{
//                                let supplement = Supplementaries()
//                                supplement.id = "\(start.day)"// key
//                               // print("\(supplement.id).\(name)")
//                                supplement.fordate = start
//                                supplement.color.append(subjectColor)
//                                supplementaries.append(supplement)
//                                //print("found first time.\(name)")
//                            }
//                        }
//                    }
//                }
//            }
            let dot = (date:Date(),colors:[VADaySupplementary.bottomDots(colorarray)])
            var dots = [dot]
            for supplement in supplementaries
            {
                let dot = (date:supplement.fordate,colors:[VADaySupplementary.bottomDots(supplement.color)])
                dots.append(dot as! (date: Date, colors: [VADaySupplementary]))
            }
            calendarView.setSupplementaries(dots)
        }
            view.addSubview(calendarView)
}
    func showsubjectevent(subject:Subject)
    {
        //print(subject.subjectName)
        guard var start = subject.date,let end = subject.dateend ,let color = subject.colorimage,let name = subject.subjectName else{return}
        let calendar2 = Calendar.current
        while start < end {
            start = calendar2.date(byAdding: .day, value: 1, to: start)!
            let subjectColor = colorEvent(namecolor: color)
            for days in subject.dayofweek
            {
                let id = "\(start.day).\(start.month).\(start.year)"
                if (start.weekdayOrdinal == days)
                {
                    if let dateindex = Search(datestring: id) {
                        supplementaries[dateindex].subjects.append(name)
                        print(name)
                        supplementaries[dateindex].color.append(subjectColor)
                    }
                    else{
                        let supplement = Supplementaries()
                        supplement.id = id // key
                        supplement.fordate = start
                        supplement.color.append(subjectColor) //อันเจอก่อนขึ้นสีก่อน
                        supplementaries.append(supplement) //ไม่เจอก็แอดเข้าไปก่อนรอบนึงจากนั้นมันจะโชว์
                    }
                }
            }
        }
    }
    
    func getEvent(name:String,start:Date,end:Date,list:Subject,color:Subject)
    {   var startdate = start
        let calendar2 = Calendar.current
        while startdate < end {
            startdate = calendar2.date(byAdding: .day, value: 1, to: startdate)!
            for days in list.dayofweek
            {
                if (start.weekdayOrdinal == days)
                {
                    if let dateindex = Search(datestring: start.description) {
                        //print("found.\(dateindex)")
                        supplementaries[dateindex].subjects.append(name)
                        supplementaries[dateindex].color.append(.black)
                    }
                    else
                    {
                        let supplement = Supplementaries()
                        supplement.id = start.description
                        supplement.fordate = start
                        supplement.color.append(.black)
                        supplementaries.append(supplement)
                        //print("create new model")
                    }
                }
            }
        }
    }

    func colorEvent(namecolor:String) -> UIColor
    {
        var colorui:UIColor!
        switch namecolor{
        case ("blackblue"):
            colorui = UIColor(red:0.37, green:0.53, blue:0.62, alpha:1.0)
            //colorui = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        //print("blackblue")
        case ("blue"):
            colorui = UIColor(red:0.07, green:0.51, blue:0.67, alpha:1.0)
            //colorui = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        //print("blue")
        case ("Marina"):
            colorui = UIColor(red:0.31, green:0.52, blue:0.75, alpha:1.0)
            //colorui = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        //print("Marina")
        case ("Aqua"):
            colorui = UIColor(red:0.52, green:0.81, blue:0.82, alpha:1.0)
            //colorui = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        //print("Aqua")
        case ("lightblue"):
            colorui = UIColor(red:0.64, green:0.83, blue:0.87, alpha:1.0)
            //colorui = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        // print("lightblue")
        case ("brown"):
            colorui = UIColor(red:0.77, green:0.56, blue:0.44, alpha:1.0)
            //colorui = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        //print("brown")
        case ("goldearth"):
            colorui = UIColor(red:0.87, green:0.61, blue:0.45, alpha:1.0)
            //colorui = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        //print("goldearth")
        case ("cressgreen"):
            colorui = UIColor(red:0.74, green:0.66, blue:0.35, alpha:1.0)
            //colorui = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        //print("cressgreen")
        case ("green"):
            colorui = UIColor(red:0.56, green:0.67, blue:0.39, alpha:1.0)
            //colorui = UIColor.red
        //print("green")
        case ("lemongrass"):
            colorui = UIColor(red:0.86, green:0.83, blue:0.61, alpha:1.0)
            //colorui = UIColor.blue
        //print("lemongrass")
        case ("suaterne"):
            colorui = UIColor(red:0.77, green:0.71, blue:0.37, alpha:1.0)
        //print("suaterne")
        case ("yellow"):
            colorui = UIColor(red:0.99, green:0.69, blue:0.32, alpha:1.0)
        //print("yellow")
        case ("red"):
            colorui = UIColor(red:0.84, green:0.24, blue:0.38, alpha:1.0)
        //print("red")
        case ("purple"):
            colorui = UIColor(red:0.72, green:0.42, blue:0.62, alpha:1.0)
        //print("purple")
        case ("greypink"):
            colorui = UIColor(red:0.92, green:0.81, blue:0.78, alpha:1.0)
        //print("greypink")
        default:
            print("day")
        }
        return colorui
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
        //print(supplementaries.count,"Search")
       return item
    }
    
    @IBAction func changeMode(_ sender: Any)
    {
//        calendarView.changeViewType()
    }
    

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
        print(dateselect)
    }
    
}


