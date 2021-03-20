//
//  SideMenu.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-20.
//

import Foundation
import SideMenu


protocol MenuControllerDelagate{
    func didSelectMenuItem(named:String)
}

class MenuController: UITableViewController{
    
    public var delagate : MenuControllerDelagate? ;
    private let menuItems: [String];
    private let mainColor = UIColor(red: 3/255.0, green: 3/255.0, blue: 3/255.0, alpha: 1);
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
        tableView.backgroundColor = mainColor;
        view.backgroundColor = mainColor;
    }
    override func tableView(_ tableView:UITableView,cellForRowAt indexPath: IndexPath )-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = mainColor
        cell.contentView.backgroundColor = mainColor
        
        return cell;
    }
    //used to handle when a tablerow has beww selcted
    override func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    
        //tell app to go to the next view
        let selectedItem = menuItems[indexPath.row]
        delagate?.didSelectMenuItem(named: selectedItem)
    }
}
