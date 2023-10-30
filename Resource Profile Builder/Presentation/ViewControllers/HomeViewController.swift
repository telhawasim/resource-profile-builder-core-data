//
//  HomeViewController.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 29/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - OUTLETS -
    
    //UILabel
    @IBOutlet weak var lblTotalEmployees: UILabel!
    //UITableView
    @IBOutlet weak var tableView: UITableView!
    //NSLayoutConstraint
    @IBOutlet weak var drawerWidth: NSLayoutConstraint!
    //UIButton
    @IBOutlet weak var btnCloseDrawer: UIButton!
    //UIView
    @IBOutlet weak var drawerView: UIView!
    
    //MARK: - VARIABLES -
    var model: [Employees] = []
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.leftGesture()
    }
    
    //MARK: - BUTTON DRAWER PRESSED -
    @IBAction func btnDrawerPressed(_ sender: Any) {
        self.openDrawer()
    }
    
    //MARK: - BUTTON CLOSE DRAWER PRESSED -
    @IBAction func btnCloseDrawerPressed(_ sender: Any) {
        self.closeDrawer()
    }
    
    //MARK: - BUTTON ADD EMPLOYEE PRESSED -
    @IBAction func btnAddEmployeePressed(_ sender: Any) {
        Routing.shared.navigateToAddEmployee(navigationController: self.navigationController)
    }
}

//MARK: - FUNCTIONS -
extension HomeViewController {
    
    //MARK: - CONFIGURE TABLEVIEW -
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(EmptyTVCell.className)
    }
    
    //MARK: - LEFT GESTURE -
    private func leftGesture() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe))
        leftSwipeGesture.direction = .left
        self.drawerView.addGestureRecognizer(leftSwipeGesture)
    }
    
    //MARK: - OPEN DRAWER -
    private func openDrawer() {
        UIView.animate(withDuration: 0.3) {
            self.drawerWidth.constant = 275
            self.btnCloseDrawer.isUserInteractionEnabled = true
            self.btnCloseDrawer.backgroundColor = UIColor.gray
            self.btnCloseDrawer.alpha = 0.6
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - CLOSE DRAWER -
    private func closeDrawer() {
        UIView.animate(withDuration: 0.3) {
            self.drawerWidth.constant = 0
            self.btnCloseDrawer.isUserInteractionEnabled = false
            self.btnCloseDrawer.backgroundColor = UIColor.clear
            self.btnCloseDrawer.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - HANDLER LEFT SWIPE -
    @objc private func handleLeftSwipe() {
        self.closeDrawer()
    }
}

//MARK: - TABLEVIEW DELEGATE METHODS -
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count == 0 ? 1 : model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if model.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
            cell.setup(type: .employeeListing)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
            return cell
        }
    }
}
