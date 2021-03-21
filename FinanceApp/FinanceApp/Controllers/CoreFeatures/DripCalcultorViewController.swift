//
//  DripCalcultorViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-20.
//

import UIKit

class DripCalcultorViewController: UIViewController {


    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar();
        searchBar.backgroundColor = .red
        return searchBar
    }()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical;
        layout.sectionInset = UIEdgeInsets(top: 0
                                        , left: 0,
                                           bottom: 0,
                                           right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collection = collectionView else {
            return
        }
        
        view.addSubview(collectionView!)
        
    }
}
    

    
extension  DripCalcultorViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell();
    }
    
    

}
