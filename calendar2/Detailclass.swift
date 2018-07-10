//
//  Detailclass.swift
//  calendar2
//
//  Created by WV-MAC on 29/6/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

class Detailclass: UIViewController {
     var plistService = PlistFileService.instance
    @IBOutlet weak var coursenamesh: UILabel!
    @IBOutlet weak var classTypesh: UILabel!
    @IBOutlet weak var T1Classsh: UILabel!
    @IBOutlet weak var T2Classsh: UILabel!
    @IBOutlet weak var howoftensh: UILabel!
    @IBOutlet weak var DMY1Classsh: UILabel!
    @IBOutlet weak var DMY2Classsh: UILabel!
    @IBOutlet weak var Locationssh: UILabel!
    @IBOutlet weak var instructorsh: UILabel!
    
    var coursenamesh1: String!
    var classTypesh1: String!
    var T1Classsh1: String!
    var T2Classsh1: String!
    var howoftensh1: String!
    var DMY1Classsh1:String!
    var DMY2Classsh1:String!
    var Locationssh1:String!
    var instructorsh1:String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coursenamesh.text = self.coursenamesh1
        self.classTypesh.text = self.classTypesh1
        self.T1Classsh.text = self.T1Classsh1
        self.T2Classsh.text = self.T2Classsh1
        self.howoftensh.text = self.howoftensh1
        self.DMY1Classsh.text = self.DMY1Classsh1
        self.DMY2Classsh.text = self.DMY2Classsh1
        self.Locationssh.text = self.Locationssh1
        self.instructorsh.text = self.instructorsh1
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addclasscon(_ sender: UIButton)
    {
//        guard  let coursename = coursenamesh.text else { return }
//        guard let classType = classTypesh.text else {return}
//        guard let howoften = howoftensh.text else {return}
//        guard let locations = Locationssh.text else {return}
//        guard let instructor = instructorsh.text else {return}
        //let  = DMYClasspicker.date
        
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
