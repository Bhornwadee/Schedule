//
//  Openapp.swift
//  calendar2
//
//  Created by WV-MAC on 4/7/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

class Openapp: UIViewController {

    @IBOutlet weak var scheduler: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Enter_btn(_ sender: UIButton)
    {
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as? MainTabController
        
        //[..] starting point
        mainTabController?.selectedViewController = mainTabController?.viewControllers?[0]
        
        //change index first to the middle or last index
        //get as starting point
        present(mainTabController!, animated: true, completion: nil)
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
