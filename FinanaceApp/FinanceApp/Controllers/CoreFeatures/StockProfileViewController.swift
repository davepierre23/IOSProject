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
        //build our table view
        let nib = UINib(nibName: "StockProfileTableViewCell", bundle: nil )
        view.backgroundColor = .systemBackground
        tableView.register(nib, forCellReuseIdentifier: "StockProfileTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.updateView(newModel : self.model)

        //build the search bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    //when the seach bar is clicked handle the seach stock profile
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
     
        guard let ticker = searchBar.text else{
            return
        }
        searchController.searchBar.text = ""
        loadStockProfile(ticker: ticker)
    }
    // build our table view functions
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
       
        //used to update the view
       func updateView(newModel : [StockProfile]){
           self.model = newModel
           self.tableView.reloadData()
       }
    // bulit a an alert if there an error
    func showErrorAlert(){
        let alert = UIAlertController(title: "Notify", message: "There was an error getting Stock Information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel , handler: { action in
        } ))
        present(alert, animated: true)
    }
    //function used to load a sotck profile knowing its ticker
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
                        case let .success(image): 
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


 
    
 
    
    
    

 
                        
