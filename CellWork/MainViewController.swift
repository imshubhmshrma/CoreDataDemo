//
//  ViewController.swift
//  CellWork
//  
//  Created by Shubham Sharma on 19/07/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ControlRepetition{
    var isSelectedd: Bool? = false
    var isSecuredd: Bool? = false
}


class MainViewController: UIViewController {

    var cellDetails: [NSManagedObject] = []
    var userIdd: Int = 0
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtNumber: UIBarButtonItem!
    var coreDataTuples: [CoreDataTuple] = []
    var bla : [ControlRepetition] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       showData()
    }
    @IBAction func actionAddCell(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        vc.varRefreshMainController = self
        vc.cellId = self.userIdd
        self.navigationController?.pushViewController(vc, animated: true)//present(vc, animated: true, completion: nil)
    }
    
}

extension MainViewController :RefreshMainController{
    func didRefresh(_ isRefresh: Bool) {
        if isRefresh == true{
             showData()
        }
    }
}


extension MainViewController{
    //MARK:- Core Data Functions
    
    func deletCell(index: Int,id : Int){
  
        let noteEntity = "CellDetails" //Entity Name
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       //
        //fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        let note = cellDetails[index] as! NSManagedObject
        managedContext.delete(note)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            self.view.makeToast("Error While Deleting Cell at index: \(index)")
            print("Error While Deleting Note: \(error.userInfo)")
        }
        // self.showData()
        //Code to Fetch New Data From The DB and Reload Table.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)

        do {
            cellDetails = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            self.view.hideToastActivity()
            self.view.makeToast("Cell at index: \(index) deleted")

        } catch let error as NSError {
            self.view.hideToastActivity()
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
//                self.coreDataTuples.removeAll()
//                var index = 0
//                print("👆🏻 \(cellDetails.count)")
//                while index < cellDetails.count{
//                    let id = cellDetails[index].value(forKeyPath: "id") as? Int32
//                    let t11 = cellDetails[index].value(forKeyPath: "text1") as? String
//                    let t22 = cellDetails[index].value(forKeyPath: "text2") as? String
//                    let imgg = cellDetails[index].value(forKeyPath: "imagge") as? NSData
//                    let coreDataTuplessss = CoreDataTuple(id: id!, t1: t11!, t2: t22!, imagge: imgg!)
//                    self.coreDataTuples.append(coreDataTuplessss)
//                    index = index + 1
//                }
        self.coreDataTuples.removeAll()
        for obj in cellDetails{
            let bla2 = obj.toDict()
            let blaDatatuple = CoreDataTuple(dictionary: bla2 as NSDictionary)
            self.coreDataTuples.append(blaDatatuple)
        //    print("ObjDisc===\(bla2)")
            
        }
        self.txtNumber.title = "\(cellDetails.count)"
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    func updateCell(index: Int,
                    id: Int32,
                    txt1:String,
                    txt2:String ,
                    img : NSData){
                //1
//                self.view.makeToastActivity(.center)
                let noteEntity = "CellDetails" //Entity Name
             let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//                //Code to Fetch New Data From The DB and Reload Table.
//               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)
//
//                do {
//                    cellDetails = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
//                    self.view.hideToastActivity()
//                } catch let error as NSError {
//                    print("Error While Fetching Data From DB: \(error.userInfo)")
//                    self.view.hideToastActivity()
//                }
        
        let note = cellDetails[index] as! NSManagedObject
        
        note.setValue(txt1, forKeyPath: "text1")
        note.setValue(txt2, forKey: "text2")
        note.setValue(img, forKey: "imagge")
        do {
            try note.managedObjectContext?.save()
            //managedContext.insert(note)
            self.view.makeToast("Cell updated at index \(index)")
            self.view.hideToastActivity()
        } catch let error as NSError {
            print("Error While updated Note: \(error.userInfo)")
            self.view.hideToastActivity()
        }
        
     //Code to Fetch New Data From The DB and Reload Table.
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)
        do {
            cellDetails = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
        
        self.coreDataTuples.removeAll()
        for obj in cellDetails{
            let bla2 = obj.toDict()
            let blaDatatuple = CoreDataTuple(dictionary: bla2 as NSDictionary)
            self.coreDataTuples.append(blaDatatuple)
           // print("ObjDisc===\(bla2)")
            
        }
        self.txtNumber.title = "\(cellDetails.count)"
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
//         let bla = self.tblView.cellForRow(at: IndexPath(row: Int(index), section: 0)) as!  WorkTableViewCell
//         self.coreDataTuples.remove(at: index)
        
//                self.coreDataTuples.removeAll()
//                var index = 0
//                print("👆🏻 \(cellDetails.count)")
//                while index < cellDetails.count{
//                    let id = cellDetails[index].value(forKeyPath: "id") as? Int32
//                    let t11 = cellDetails[index].value(forKeyPath: "text1") as? String
//                    let t22 = cellDetails[index].value(forKeyPath: "text2") as? String
//                    let imgg = cellDetails[index].value(forKeyPath: "imagge") as? NSData
//                    let coreDataTuplessss = CoreDataTuple(id: id!, t1: t11!, t2: t22!, imagge: imgg!)
//                    self.coreDataTuples.append(coreDataTuplessss)
//                    index = index + 1
//                }
        
     

        
    }
    
}
extension MainViewController{
    @objc func actionSelectUnselect(_ sender : UIButton){
         let index = sender.tag
        coreDataTuples[index].isSelectedd = !coreDataTuples[index].isSelectedd!
        for indexx in 0..<coreDataTuples.count where indexx != index {
            print("😜",indexx)
            self.coreDataTuples[indexx].isSelectedd = false
        }
        DispatchQueue.main.async {
             self.tblView.reloadData()
        }
       
        //self.tblView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
        
    }
    @objc func actionDelete(_ sender : UIButton){
           let index = sender.tag
        let blaDetailData = self.coreDataTuples[index]
        let adkak =  Int("\(blaDetailData.id!)")
        print("😜😜",adkak)
        deletCell(index: index, id: adkak!)
    }
    @objc func actionEdit(_ sender : UIButton){
         let index = sender.tag
        let bla = self.tblView.cellForRow(at: IndexPath(row: Int(index), section: 0)) as!  WorkTableViewCell
        if bla.txtFirst.tag == index && bla.txtSecond.tag == index{
            bla.txtFirst.isUserInteractionEnabled = true
            bla.txtSecond.isUserInteractionEnabled = true
        }
    }
    @objc func actionUpdate(_ sender : UIButton){
        let index = sender.tag
        let blaBla = self.coreDataTuples[index]
        let bla = self.tblView.cellForRow(at: IndexPath(row: Int(index), section: 0)) as!  WorkTableViewCell
        if index == bla.txtFirst.tag && index == bla.txtSecond.tag{
        //self.tblView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
          //  self.updateCell(index: index, txt1: bla.txtFirst.text!, txt2: bla.txtSecond.text!, img: <#NSData#>)
            let newImageData = bla.imggView.image?.jpegData(compressionQuality: 0.4)//
            self.updateCell(index: index, id: blaBla.id!, txt1: bla.txtFirst.text!, txt2: bla.txtSecond.text!, img: newImageData! as NSData)
        }
    }
    @objc func actionHide(_ sender : UIButton){
        let index = sender.tag
        print("😆",index)
        coreDataTuples[index].isSecuredd = !coreDataTuples[index].isSecuredd!
        self.tblView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
    }
    @objc func actionUpdateImage(_ sender : UIButton){
        let index = sender.tag
        print("😆",index)
        var imagee: UIImage?
        var blaBla = self.coreDataTuples[index]
        
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            print("the picked up image is ",image)
            imagee = image
            blaBla.imagge = image.jpegData(compressionQuality: 0.4)! as NSData
            self.updateCell(index: index, id: blaBla.id!, txt1: blaBla.textFirst!, txt2: blaBla.textSecond!, img: blaBla.imagge!)
        //   blaBla.imagge = UIImage.pngData(image)
        }
//        let bla = self.tblView.cellForRow(at: IndexPath(row: Int(index), section: 0)) as!  WorkTableViewCell
//        bla.imggView.image = imagee
//        self.tblView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
    }
    
}
extension MainViewController: UITableViewDelegate{
     func showData(){

        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "CellDetails")
        
        //3
        do {
            cellDetails = try managedContext.fetch(fetchRequest)
            self.view.hideToastActivity()
        } catch let error as NSError {
             self.view.hideToastActivity()
            print("Could not fetch. \(error), \(error.userInfo)")
        }
 
        self.coreDataTuples.removeAll()
        for obj in cellDetails{
            let bla2 = obj.toDict()
            let blaDatatuple = CoreDataTuple(dictionary: bla2 as NSDictionary)
            self.coreDataTuples.append(blaDatatuple)
             //print("ObjDisc===\(bla2)")
        }
                //lblNumberOfItems.text = "Number of Items: \(locationCredentials.count)"
                DispatchQueue.main.async {
                     self.tblView.reloadData()
                }
                getMaxId()
        
        
//            while index < self.cellDetails.count{
//                let id = self.cellDetails[index].value(forKeyPath: "id") as? Int32
//                let t11 = self.cellDetails[index].value(forKeyPath: "text1") as? String
//                let t22 = self.cellDetails[index].value(forKeyPath: "text2") as? String
//                let imgg = self.cellDetails[index].value(forKeyPath: "imagge") as? NSData
//                //print("😆",id!, t11 , t22 , imgg)
//                let coreDataTuplessss = CoreDataTuple(id: id!, t1: t11!, t2: t22!, imagge: imgg!)
//                self.coreDataTuples.append(coreDataTuplessss)
//                index = index + 1
//            }
//
      
//        self.txtNumber.title = "\(cellDetails.count)"
//        //lblNumberOfItems.text = "Number of Items: \(locationCredentials.count)"
//        DispatchQueue.main.async {
//             self.tblView.reloadData()
//        }
//        getMaxId()
//        
    }
    
    func convertToJSONArray(moArray: [NSManagedObject]) -> Any {
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                //check if value is present, then add key to dictionary so as to avoid the nil value crash
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    func getMaxId(){
        //userIdd = userIdd + 1
        for items in cellDetails{
            let itemsId = items.value(forKey: "id") as? Int
            if userIdd < itemsId!{
                userIdd = itemsId!
            }
        }
        //cellDetails
    }
}
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDetails.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTableViewCell", for: indexPath) as! WorkTableViewCell
         bla = Array(repeating: ControlRepetition() , count: cellDetails.count)
         let tag = indexPath.row
        //  let cellDetailData = cellDetails[indexPath.row]
        // let bla2 = cellDetailData.toDict()
        //print("😅",bla2)
         let blaDetailData = self.coreDataTuples[tag]
        
        cell.btnDelete.tag = tag
        cell.btnSelectUnselect.tag = tag
        cell.btnEdit.tag = tag
        cell.txtSecond.tag = tag
        cell.txtFirst.tag = tag
        cell.btnUpdate.tag = tag
        cell.btnHide.tag = tag
        cell.btnImgUpdate.tag = tag
        cell.imggView.tag = tag
        
       if blaDetailData.isSecuredd == true{
            cell.txtFirst.isSecureTextEntry = true
            cell.txtSecond.isSecureTextEntry = true
        }  else if blaDetailData.isSecuredd == false{
        cell.txtFirst.isSecureTextEntry = false
        cell.txtSecond.isSecureTextEntry = false
        }
       if blaDetailData.isSelectedd == true{
       print("selected")
       cell.btnSelectUnselect.setImage(UIImage(named: "check-box"), for: .normal)
        } else if bla[tag].isSelectedd == false{
         print("Unselected")
         cell.btnSelectUnselect.setImage(UIImage(named: "blank-square"), for: .normal)
       }
 
         print("cellDetailData",blaDetailData)
        if let bla3 = blaDetailData.imagge {
            let cellImage =  UIImage(data: bla3 as Data)
            cell.imggView?.image = cellImage
        }
        
        
       
         cell.txtSecond.isUserInteractionEnabled = false
         cell.txtFirst.isUserInteractionEnabled = false
         cell.txtFirst.text! = blaDetailData.textFirst!
         cell.txtSecond.text! = blaDetailData.textSecond!
        
     
         cell.btnSelectUnselect.addTarget(self, action: #selector(actionSelectUnselect), for: .touchUpInside)
         cell.btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
         cell.btnEdit.addTarget(self, action: #selector(actionEdit), for: .touchUpInside)
         cell.btnUpdate.addTarget(self, action: #selector(actionUpdate), for: .touchUpInside)
         cell.btnHide.addTarget(self, action: #selector(actionHide), for: .touchUpInside)
         cell.btnImgUpdate.addTarget(self, action: #selector(actionUpdateImage), for: .touchUpInside)
        return cell
    }   
}





// MARK: Trash Code

/* self.view.makeToastActivity(.center)
 let noteEntity = "CellDetails" //Entity Name
 
 let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 let entity = NSEntityDescription.entity(forEntityName: noteEntity, in: managedContext)
 let req = NSFetchRequest<NSFetchRequestResult>()
 req.entity = entity
 let predicate = NSPredicate(format: "id = %d", id)
 req.predicate = predicate
 do {
 let result  = try managedContext.fetch(req)
 let objUpdate = result[0] as! NSManagedObject
 objUpdate.setValue(id, forKey: "id")
 objUpdate.setValue(txt1, forKey: "text1")
 objUpdate.setValue(txt2, forKey: "text2")
 //            let image = userImage.image!
 //            let imageData = image.jpegData(compressionQuality: 0.50)
 objUpdate.setValue(img, forKey: "imagge")
 
 do {
 try managedContext.save()
 
 }
 catch {
 print(error)
 }
 
 } catch _{
 
 } */
