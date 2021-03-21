//
//  InfoViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-20.
//

import UIKit

class InfoViewController: UIViewController, UISearchBarDelegate {

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .vertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        
        
        searchBar.delegate = self
        

        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50));
        
        view.addSubview(button);
        view.addSubview(searchBar)
        
        button.backgroundColor = .systemPurple;
        button.center = view.center;
        button.setTitle("Infor", for: .normal);
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside);
    }
    
    
    @IBAction func didTapButton(){
        
    }
    
    override func viewDidLayoutSubviews() {
        searchBar.frame = CGRect(x:100,y:view.safeAreaInsets.top+55,width:view.frame.size.width, height : view.frame.size.height-55)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            print(text)
        }
    }

}
