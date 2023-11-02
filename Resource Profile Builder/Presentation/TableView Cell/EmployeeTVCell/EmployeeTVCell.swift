//
//  EmployeeTVCell.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 01/11/2023.
//

import UIKit

class EmployeeTVCell: UITableViewCell {
    
    //MARK: - OUTLETS -
    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    //MARK: - VARIABLES -
    
    //MARK: - LIFECYCLE -
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    //MARK: - CONFIGURE CELL -
    func configure(data: Employee) {
        self.lblName.text = data.name
        self.lblDesignation.text = data.designation?.designation
        self.lblEmail.text = data.email
        self.imgProfilePicture.image = data.profilePicture.toImage()
    }
}
