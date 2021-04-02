//
//  StockProfileViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-30.
//

import UIKit

class StockProfileViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    @IBOutlet  var tableView: UITableView!
    var searchController :UISearchController!
    var ticker : String = ""

    //used to hold the infromation that was found by the request
    private var model :[StockProfile] = [StockProfile]();

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Stock Profile"
        let nib = UINib(nibName: "StockProfileTableViewCell", bundle: nil )
        view.backgroundColor = .systemBackground
        tableView.register(nib, forCellReuseIdentifier: "StockProfileTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.updateView(newModel : self.model)

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController

    
        print("intialStock ticker :\(ticker)")
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
     
        guard let ticker = searchBar.text else{
            return
        }
        searchController.searchBar.text = ""
        loadStockProfile(ticker: ticker)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.bounds.height)
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockProfileTableViewCell", for: indexPath) as? StockProfileTableViewCell else {
            return UITableViewCell()
               
           }
        
          cell.configure(wtih: model[indexPath.row])
            return cell
       }
       
     
       func updateView(newModel : [StockProfile]){
           self.model = newModel
           self.tableView.reloadData()
       }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Notify", message: "There was an error getting Stock Information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel , handler: { action in
        } ))
        present(alert, animated: true)
    }
    
    func loadStockProfile(ticker:String) {
        self.tableView.reloadData()
        let stockStore = StockStore()
        stockStore.fetchStockProfile(ticker: ticker , completion: {
            stockProfileResult in
            switch stockProfileResult {
            case let .success(stockProfileResult):
                print("Successfully found \(String(describing: stockProfileResult)) Stocks.")
                if let stockFirst = stockProfileResult.first {
                    print(stockFirst)
                    OperationQueue.main.addOperation {
                        self.updateView(newModel: stockProfileResult)
                    }
                    stockStore.fetchImage(for: stockFirst) {
                    (imageResult) -> Void in
                        switch imageResult {
                        case let .success(image): //self.imageView.image = image
                            OperationQueue.main.addOperation {
                                stockFirst.image = image
                                self.updateView(newModel: stockProfileResult)
                            }
                        case let .failure(error): print("ERROR downloading actual image: \(error)")
                        }
                    }
                }

            case let .failure(error):
                print ("Error fetching recent Stocks: \(error)")
                OperationQueue.main.addOperation {
                    self.showErrorAlert()
                }
        
            }
        })
        
    }
}


 
    
 
    
    
    

 
                        
