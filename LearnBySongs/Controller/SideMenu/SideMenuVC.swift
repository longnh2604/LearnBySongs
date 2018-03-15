//
//  SideMenuVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import RealmSwift

enum LeftMenu: Int {
    case main = 0
    case setting
    case login
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class SideMenuVC: UIViewController, LeftMenuProtocol {
    
    var menus = ["Home", "Setting", "Logout"]
    var mainViewController: UIViewController!
    var settingViewController: UIViewController!
    var loginViewController: UIViewController!
    var users: Results<UserData>!
    
    @IBOutlet weak var tblSideMenu: UITableView!
    @IBOutlet weak var imvUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserType: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = RealmServices.shared.realm
        users = realm.objects(UserData.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.mainViewController = UINavigationController(rootViewController: mainVC)
        
        let settingVC = storyboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.settingViewController = UINavigationController(rootViewController: settingVC)
        
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.loginViewController = UINavigationController(rootViewController: loginVC)
        
        setupUI()
    }

    //MARK: - Load UI
    /***************************************************************/
    func setupUI() {
        tblSideMenu.tableFooterView = UIView()
        tblSideMenu.delegate = self
        tblSideMenu.dataSource = self
        
        lblUsername.text = users[0].userName
        
        lblUserType.text = getUserType(type: users[0].userType)
        
        if let url = URL.init(string: users[0].userImage) {
            imvUser.downloadedFrom(url: url)
            imvUser.roundImage(with: imvUser)
        }
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .setting:
            self.slideMenuController()?.changeMainViewController(self.settingViewController, close: true)
        case .login:
            UserDefaults.standard.set("logout", forKey: "LoginState")
            UserDefaults.standard.synchronize()
            RealmServices.shared.deleteAll()

            let loginView =  self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.present(loginView, animated: true, completion: nil)
        }
    }
}

//MARK: - Tableview Delegate, Datasource
/***************************************************************/
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell") as! SideMenuCell
        cell.lblTitle.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
