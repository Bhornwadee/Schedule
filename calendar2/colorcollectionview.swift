//
//  colorcollectionview.swift
//  calendar2
//
//  Created by WV-MAC on 3/7/2561 BE.
//  Copyright © 2561 WV-MAC. All rights reserved.
//

import UIKit

protocol ColorcollectionviewDelegate: class {
    func changeBackgroundColor(picture: String)
}
class colorcollectionview: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate {

    var delegate:ColorcollectionviewDelegate?
    @IBOutlet weak var mycollection: UICollectionView!
    var array = ["blackblue","blue","Marina","Aqua","lightblue","brown","goldearth","cressgreen","green","lemongrass","suaterne","yellow","red","purple","greypink"]
    override func viewDidLoad() {
        super.viewDidLoad()
        mycollection.dataSource = self
        mycollection.delegate = self
        let itemsize = UIScreen.main.bounds.width/3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        mycollection.collectionViewLayout = layout
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! MyCollectionViewCell  //reusecell ->จะนำcellมาใช้เรื่อยๆ
        cell.mycellimage.image = UIImage(named: array[indexPath.row]) //เรียกรูปในcollectionviewcellมาใช้งาน
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var choosecolor = array[indexPath.item]
        print(choosecolor)
        delegate?.changeBackgroundColor(picture: choosecolor)
        _ = navigationController?.popViewController(animated: true)
       // let selectedCell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
       // AddCourse.colorimage.image = selectedCell.imageView.image
        //print(array[indexPath.item]) //printค่าในarrayออกมา เลือกสีไหนออกชื่อสีนั้น
        
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
