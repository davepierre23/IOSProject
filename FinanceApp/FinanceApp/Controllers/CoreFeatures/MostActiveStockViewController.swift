//
//  MostActiveStockViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-30.
//

import UIKit

class MostActiveStockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet  var tableView: UITableView!
    private var model :[ActiveStock] = [ActiveStock]();
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MostActiveStockViewController")

        title = "Most Active \(model.count) Stocks"
        let nib = UINib(nibName: "ActiveStockTableViewCell", bundle: nil )
        view.backgroundColor = .systemBackground
        tableView.register(nib, forCellReuseIdentifier: "ActiveStockTableViewCell")
        tableView.rowHeight = 60;
        loadMostActiveStocks()
        tableView.delegate = self
        tableView.dataSource = self

 
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveStockTableViewCell", for: indexPath) as? ActiveStockTableViewCell else { return UITableViewCell()
            
        }
        
        cell.configure(wtih: model[indexPath.row])
        return cell
    }

    func loadMostActiveStocks(){
        let stockStore = StockStore()
        stockStore.fetchMostActiveStocks{
            (activeStockResult) -> Void in
            switch activeStockResult {
            case let .success(activeStocks):
                print("Successfully found \(activeStocks.count) Stocks.")
                OperationQueue.main.addOperation {
                    self.updateView(newModel: activeStocks)
                  
                }

            case let .failure(error):
                print ("Error fetching recent Stocks: \(error)")
            }
        }
        
    }
    
    //update date the view and the elements that depend on it 
    func updateView(newModel: [ActiveStock]){
        self.model = newModel
        self.title = "Most Active \(self.model.count) Stocks"
        self.tableView.reloadData()

    }

}
