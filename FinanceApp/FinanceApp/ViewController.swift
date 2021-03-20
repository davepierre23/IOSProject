//
//  ViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-20.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    private let sideMenu = SideMenuNavigationController(rootViewController: UIViewController());
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)

        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50));
        
        view.addSubview(button);
        
        button.backgroundColor = .systemPurple;
        button.center = view.center;
        button.setTitle("Show Tab Bar", for: .normal);
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside);
        
    }

    @IBAction func didTapButton(){
        present(sideMenu, animated: true)
    }
    
    
}
class MenuController: UITableViewController{
//    private let menuItems!: [String];
//
//    init(with menuItems: [String]){
//        super.init(nibName:nil,bundle:nil)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Table methods
    
//    override func tableView(_ tableView:UITableView,numberOfRowsInSection section :Int)->Int{
//        return menuItems.count;
//    }
//    override func tableView(_ tableView:UITableView,cellForRowAt IndexPath: IndexPath :Int)->UITableViewCell{
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:IndexPath)
//        cell.texxt
//        return menuItems.count;
//    }
//
    
    
}

