//
//  MostActiveStockViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-30.
//

import UIKit

class MostActiveStockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Most Active Stocks"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }

    func loadMostActiveStocks(){
        let stockStore = StockStore()
        stockStore.fetchMostActiveStocks{
            (activeStockResult) -> Void in
            switch activeStockResult {
            case let .success(activeStocks):
                print("Successfully found \(activeStocks.count) Stocks.")

            case let .failure(error):
                print ("Error fetching recent Stocks: \(error)")
            }
        }
        
    }

}
