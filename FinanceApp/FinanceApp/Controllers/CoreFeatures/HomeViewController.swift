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
    case SearchTicker = "Search Ticker"
    case setting = "Setting"
}
class HomeViewController: UIViewController, MenuControllerDelagate {

    public var sideMenu : SideMenuNavigationController?;
    
    private let infoController  = InfoViewController();
    private let searchViewController = SeachTickerViewController();
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
        
        //button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside);
        
    }
    private func addChildController(){
        addChild(infoController)
        addChild(searchViewController)
        view.addSubview(infoController.view)
        infoController.view.frame = view.bounds
        infoController.didMove(toParent: self);
        infoController.view.isHidden = true;
        
        view.addSubview(infoController.view)
        searchViewController.view.frame = view.bounds
        searchViewController.didMove(toParent: self);
        searchViewController.view.isHidden = true;
    }

    @IBAction func didTapButton(){
        present(sideMenu!, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        createTimer()
    }
    
    func createTimer(){
        let timeInterval2 = 2
        // create a timer that fires a methhod every second
        let timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false);
        
        // give a tolernace of that relax the progame
        timer.tolerance = 200
        // fire the timer when ever its free
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            timer.fire()
        })
    }
    
    @objc func fireTimer(){
        view.backgroundColor = .systemRed;
    }
    
    func didSelectMenuItem(named:SideMenuItem){
        // when some clicks on a menu item close the menu and set the correspond menu
        sideMenu?.dismiss(animated:true, completion: nil)
            
            //set the name of the title to be the View name
            title = named.rawValue
            
            // iterate through the enum and set the apprioate view
            switch named{
            case .home :
                infoController.view.isHidden = true;
      
            case .info :
                infoController.view.isHidden = false;
        
            case .SearchTicker:
                infoController.view.isHidden = true;
                searchViewController.view.isHidden = false;
             
            case .setting :
                infoController.view.isHidden = true;
                self.view.isHidden = true
        
            }
            

    }
    

    
}


    

