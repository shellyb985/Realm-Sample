//
//  StudentCellTableViewCell.swift
//  Realm Swift
//
//  Created by Administrator on 12/12/17.
//  Copyright © 2017 spb. All rights reserved.
//

import UIKit

class StudentCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblStudentAge: UILabel!
    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
