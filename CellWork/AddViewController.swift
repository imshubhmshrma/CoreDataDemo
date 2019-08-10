//
//  AddViewController.swift
//  CellWork
//
//  Created by Shubham Sharma on 19/07/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData
protocol RefreshMainController {
    func didRefresh(_ isRefresh: Bool)
}
class AddViewController: UIViewController {
    
    var cellId: Int = 0
    
    var cellDetails: [NSManagedObject] = []
    var varRefreshMainController: RefreshMainController?
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var imggView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        cellId = cellId + 1
        // Do any additional setup after loading the view.
    }
    @IBAction func actionPickImage(_ sender: UIButton) {
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            print("the picked up image is ",image)
           self.imggView.image = image
            
        }
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
    @IBAction func actionCancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
      //  self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
        if txt1.text?.isEmpty == false && txt2.text?.isEmpty == false && imggView.image != nil{
            self.save(txt1: txt1.text!, txt2: txt2.text!, immg: self.imggView.image!)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AddViewController{
    func save(txt1: String , txt2: String , immg : UIImage) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "CellDetails",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        let newImageData = immg.jpegData(compressionQuality: 0.4)
        // 3
        person.setValue(self.cellId, forKeyPath: "id")
        person.setValue(txt1, forKeyPath: "text1")
        person.setValue(txt2, forKey: "text2")
        person.setValue(newImageData, forKey: "imagge")
        // 4
        do {
            try managedContext.save()
            self.cellDetails.append(person)
            self.view.makeToast("Value Saved")
          //  let bla = convertToJSONArray(moArray: cellDetails)
          //  print("👆🏻👆🏻👆🏻👆🏻👆🏻👆🏻👆🏻",bla)
            if let someObjDelegate = self.varRefreshMainController{
                someObjDelegate.didRefresh(true)
                
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            self.view.makeToast("Please try after sometime")
            
        }
        
       self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddViewController{
   
}
