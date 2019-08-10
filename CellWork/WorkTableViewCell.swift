//
//  WorkTableViewCell.swift
//  CellWork
//
//  Created by Shubham Sharma on 19/07/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {

    static var identifier = "WorkTableViewCell"
    @IBOutlet weak var btnSelectUnselect: UIButton!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnHide: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnImgUpdate: UIButton!
    @IBOutlet weak var imggView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        
        // reset 
       // self.btnSelectUnselect.isSelected = false
       // self.btnHide.isSelected = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
 
}
