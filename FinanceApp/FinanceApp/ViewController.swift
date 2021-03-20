//
//  ViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-20.
//

import UIKit
import SideMenu

class ViewController: UIViewController, MenuControllerDelagate {

    public var sideMenu : SideMenuNavigationController?;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let menu = MenuController(with: ["Home","Info","Setting"]);
        
        menu.delagate = self
        
        sideMenu =  SideMenuNavigationController(rootViewController: menu);
        
        sideMenu?.leftSide = true
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
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named:String){
        sideMenu?.dismiss(animated:true, completion: {[weak self] in
            if named == "Home"{
                self?.view.backgroundColor = .green
            }
            if named == "Info"{
                self?.view.backgroundColor = .red
                
            }
            if named == "Settings"{
                self?.view.backgroundColor = .orange
                
            }
            
        } )
    }
    
    
}


    

