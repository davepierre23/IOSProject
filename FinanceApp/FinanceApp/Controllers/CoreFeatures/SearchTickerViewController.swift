//
//  SearchTickerViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-30.
//

import UIKit

class SearchTickerViewController: UIViewController {

    
    private var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        //set the top part to be the search bar
        navigationController?.navigationBar.topItem?.titleView = searchBar
        


    }

    
    func searchStock(query:String, exchange: String){
        let stockStore = StockStore()
        stockStore.fetchStockResults(query: query, exchange: exchange, completion: { stockSearchResults in
            switch stockSearchResults {
            case let .success(stockSearchResults):
                print("Successfully found \(stockSearchResults.count) Stocks.")

            case let .failure(error):
                print ("Error fetching recent Stocks: \(error)")
            }

        })
        
        
    }

}


//extension SearchTickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
//private var collectionView : UICollectionView?
//
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return 10
//        }
//
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//            let layout  = UICollectionViewFlowLayout()
//            layout.scrollDirection = .vertical
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            return collectionView
//        }

//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    view.backgroundColor = .systemBackground
//    //set the top part to be the search bar
//    navigationController?.navigationBar.topItem?.titleView = searchBar
//
//    let layout  = UICollectionViewFlowLayout()
//    layout.scrollDirection = .vertical
//    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//    collectionView?.delegate = self
//    collectionView?.dataSource = self
//    guard let collectionView = collectionView else {
//        return
//    }
//    view.addSubview(collectionView)
//
//}
//}
