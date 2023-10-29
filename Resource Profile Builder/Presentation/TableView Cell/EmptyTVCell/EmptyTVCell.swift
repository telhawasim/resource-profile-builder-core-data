//
//  EmptyTVCell.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 29/10/2023.
//

import UIKit

class EmptyTVCell: UITableViewCell {
    
    //MARK: - OUTLETS -
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var btnAdd: UIButton!
    
    //MARK: - VARIABLES -
    var buttonPressed: (() -> Void)?
    
    //MARK: - LIFECYCLE -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - BUTTON ADD PRESSED -
    @IBAction func btnAddPressed(_ sender: Any) {
        self.buttonPressed?()
    }
}

//MARK: -  FUNCTIONS -
extension EmptyTVCell {
    
    //MARK: - SETUP CELL -
    func setup(type: EmptyStateType) {
        switch type {
        case .employeeListing:
            self.lblTitle.text = "No Data Available"
            self.lblDescription.text = "The information is not available for the moment"
            self.icon.image = UIImage(named: "EmptyIcon")
            self.btnAdd.isHidden = true
        }
    }
    
}
