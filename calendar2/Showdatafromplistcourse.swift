//
//  Showdatafromplistcourse.swift
//  calendar2
//
//  Created by WV-MAC on 22/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

class Showdatafromplistcourse: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var edit_btn: UIButton!
    @IBOutlet weak var TablePlistcourse: UITableView!
    var plistService = PlistFileService.instance
    var semester = [Subject]()
    var savetop = [Subject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TablePlistcourse.delegate = self
        TablePlistcourse.dataSource = self
        TablePlistcourse.separatorStyle = .none
        // plistService.setDefaultloadData()
        print("total")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        refreshdata()
    }
    
    @IBAction func Edit_Btn(_ sender: UIButton)
    {
        if (TablePlistcourse.isEditing == true)
        {
            edit_btn.setTitle("Delete", for: .normal)
            TablePlistcourse.isEditing = false
        }
        else
        {
            edit_btn.setTitle("OK", for: .normal)
            TablePlistcourse.isEditing = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //        print("numberof row \(semester.count)")
        return semester.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //return ประกาศตัวแปรขึ้นมาตัวนึง
        tableView.rowHeight = 125
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell",for: indexPath) as! customTableViewCell2
        //        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let subject = semester[indexPath.row]
        guard let subjectname = semester[indexPath.row].subjectName else{ return cell}
        guard let imagename = subject.colorimage,let image = UIImage(named:imagename) ,
            let coursetxt = semester[indexPath.row].subjectName , let datecourse = semester[indexPath.row].date ,let dateendcourse = semester[indexPath.row].dateend else {
            return cell
        }
        let deviceLocale = Locale.current.identifier //getเวลาจากเครื่อง
        let formatter = DateFormatter();
        formatter.locale = Locale(identifier: deviceLocale)
        formatter.dateFormat = "dd-MM-yyyy"; //format dmy
        let datec = formatter.string(from: datecourse)
        
        let formatter2 = DateFormatter();
        formatter2.locale = Locale(identifier: deviceLocale)
        formatter2.dateFormat = "dd-MM-yyyy"; //format dmy
        let datee = formatter2.string(from: dateendcourse)
        
        cell.courseimg.image = image
        cell.courselbl.text = coursetxt
        cell.coursedate.text = datec
        cell.courseenddate.text = datee
        //print(cell)
        return cell
        
    }
    
    //    func fetchSsmester(){
    //        for subject in plistService.getAllSubject(){
    //            guard let subName = subject.subjectName else{return}
    //            print("\(subName)")
    //        }
    //        print("fetch \(plistService.getAllSubject().count)")
    //        TablePlistcourse.reloadData()
    //    }
    
    func numberOfSections(in tableView: UITableView) -> Int //section ที่เราจะแสดงในส่วนของtableview
    {
        //ดึงอินเดกของอาเรออกมา
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Course") as? Course else{return}
       // vc?.coursetxt = plistService.getAllSubject()[indexPath.row].subjectName!
        //ส่งเป็นอาเรยไปชื่ออาเรsubject
        let subject = plistService.getAllSubject()[indexPath.row]
        vc.subject = subject
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,forRowAt indexPath: IndexPath)
    {
//        print("IndexPath",indexPath)
//        print("IndexPath Sec",indexPath.section)
//        print("IndexPath Row",indexPath.row)
        if editingStyle == .delete
        {
            TablePlistcourse.beginUpdates()
            guard let subname = semester[indexPath.row].subjectName else {return}
            plistService.Search(subjectname: subname)
            //print(subname)
            semester.remove(at: indexPath.row)
            //print(semester)
            //print(semester.remove(at: indexPath))
            TablePlistcourse.deleteRows(at: [indexPath], with: .automatic)
            TablePlistcourse.endUpdates()
           // savetop.append(semester[indexPath.row])
           // print(savetop)
        }
     
        //TablePlistcourse.beginUpdates()
        
        //semester[indexPath.section]
        ///semester.remove(at: indexPath.row)
        ////products[indexPath.section].productLists.remove(at: indexPath.row) //ลบข้อมูลที่อยู่ในอาเรย์
        
        ///TablePlistcourse.deleteRows(at: [indexPath.row], with: .automatic)
        //TablePlistcourse.deleteRows(at: [indexPath], with: .automatic)
        //TablePlistcourse.deleteRows(at: [indexPath.init(row: indexPath.row,section)], with: .fade)
        //        tableView.deleteRows(at: [IndexPath.init(row: indexPath.row, section: indexPath.section)],with: .fade)//ลบข้อมูลบนtable view
        //TablePlistcourse.endUpdates()
        //TablePlistcourse.reloadData()
        //        print(semester)
    }
    
    func  refreshdata()
    {
        semester = plistService.getAllSubject()
        TablePlistcourse.reloadData()
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


