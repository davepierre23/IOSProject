//
//  SearchTickerViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-30.
//

import UIKit

class SearchTickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
