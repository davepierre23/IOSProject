//
//  StockProfileViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-30.
//

import UIKit

class StockProfileViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func loadStockProfile(ticker:String) {
        let stockStore = StockStore()
        stockStore.fetchStockProfile(ticker: "CU.to" , completion: {
            stockProfileResult in
            switch stockProfileResult {
            case let .success(stockProfileResult):
                print("Successfully found \(String(describing: stockProfileResult)) Stocks.")
                if let firstPhoto = stockProfileResult.first {
                    print(firstPhoto)
                    stockStore.fetchImage(for: firstPhoto) {
                    (imageResult) -> Void in
                        switch imageResult {
                        case let .success(image): //self.imageView.image = image
                            OperationQueue.main.addOperation {
                                self.imageView.image = image
                            }
                        case let .failure(error): print("ERROR downloading actual image: \(error)")
                        }
                    }
                }

            case let .failure(error):
                print ("Error fetching recent Stocks: \(error)")
            }
            
        })
    
        
    }
 

}
