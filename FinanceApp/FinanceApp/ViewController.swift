//
//  ViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-20.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    private let sideMenu = SideMenuNavigationController(rootViewController: MenuController(with: ["Home","Info","Setting"]));
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
    private let menuItems: [String];

    init(with menuItems: [String]){
        self.menuItems = menuItems
        super.init(nibName:nil,bundle:nil)
      
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Table methods
    
    override func tableView(_ tableView:UITableView,numberOfRowsInSection section :Int)->Int{
        return menuItems.count;
    }
    
    override func viewDidLoad() {
        tableView.backgroundColor = .darkGray
        view.backgroundColor = .darkGray;
    }
    override func tableView(_ tableView:UITableView,cellForRowAt indexPath: IndexPath )-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.contentView.backgroundColor = .darkGray
        
        return cell;
    }
    //used to handle when a tablerow has beww selcted
    override func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    
        //tell app to go to the next view
    
    }
    
    
}

