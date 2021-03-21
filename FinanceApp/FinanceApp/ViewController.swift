//
//  ViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-20.
//

import UIKit
import SideMenu

enum SideMenuItem: String, CaseIterable{
    case home = "Home"
    case info = "Info"
    case setting = "Setting"
}
class ViewController: UIViewController, MenuControllerDelagate {

    public var sideMenu : SideMenuNavigationController?;
    
    private let infoController  = InfoViewController();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let menu = MenuController(with: SideMenuItem.allCases);
        
        menu.delagate = self
        
        sideMenu =  SideMenuNavigationController(rootViewController: menu);
        
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)

        addChildController();
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50));
        
        view.addSubview(button);
        
        button.backgroundColor = .systemPurple;
        button.center = view.center;
        button.setTitle("Show Tab Bar", for: .normal);
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside);
        
    }
    private func addChildController(){
        addChild(infoController)
        view.addSubview(infoController.view)
        infoController.view.frame = view.bounds
        infoController.didMove(toParent: self);
        infoController.view.isHidden = true;
    }

    @IBAction func didTapButton(){
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named:SideMenuItem){
        sideMenu?.dismiss(animated:true, completion: nil)
            title = named.rawValue
            
            switch named{
            case .home :
                view.backgroundColor = .green
                infoController.view.isHidden = true;
            case .info :
                view.backgroundColor = .red
                infoController.view.isHidden = false;
            case .setting :
                view.backgroundColor = .orange
                infoController.view.isHidden = true;
        
            }
            

    }
    
    
}


    

