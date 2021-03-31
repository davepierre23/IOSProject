//
//  SearchTickerViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-30.
//

import UIKit

class SearchTickerViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource ,UITextFieldDelegate, UISearchBarDelegate{
 
    
    @IBOutlet  var tableView: UITableView!
    @IBOutlet var exchangePickerView: UIPickerView!
    @IBOutlet var textFiled: UITextField!

    var searchController :UISearchController!
    var exchangeOption : String = StockAPI.exchangeOptions[0]

    var searchActive : Bool = false

    
    //used to hold the infromation that was found by the request
    private var model :[StockSearchResult] = [StockSearchResult]();

  
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search Stocks"
        let nib = UINib(nibName: "StockSearchResultsTableViewCell", bundle: nil )
        view.backgroundColor = .systemBackground
        tableView.register(nib, forCellReuseIdentifier: "StockSearchResultsTableViewCell")
        tableView.rowHeight = 100;
        tableView.delegate = self
        tableView.dataSource = self
        textFiled.delegate = self
        textFiled.text = exchangeOption
        createPickerView()
        dismissPickerView()

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController

      
    }
    
    func createPickerView() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
           textFiled.inputView = pickerView
    }
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       textFiled.inputAccessoryView = toolBar
    }
    @objc func action() {
          view.endEditing(true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let query = searchController.searchBar.text else{
            return
        }
        print(searchController.searchBar.text!)
        searchController.searchBar.text = ""
        
        let exchange = exchangeOption
        
        searchStock(query: query, exchange: exchange)
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockSearchResultsTableViewCell", for: indexPath) as? StockSearchResultsTableViewCell else { return UITableViewCell()
            
        }
        
        cell.configure(wtih: model[indexPath.row])
        return cell
    }
    
    func searchStock(query:String, exchange: String){
        let stockStore = StockStore()
        stockStore.fetchStockResults(query: query, exchange: exchange, completion: { stockSearchResults in
            switch stockSearchResults {
            case let .success(stockSearchResults):
                print("Successfully found \(stockSearchResults.count) Stocks.")
                OperationQueue.main.addOperation {
                    self.model = stockSearchResults
                    //reload data
                    self.tableView.reloadData()
                }

            case let .failure(error):
                print ("Error fetching recent Stocks: \(error)")
            }

        })
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return StockAPI.exchangeOptions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StockAPI.exchangeOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print("dialling thing")
        print(row)
        print(component)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("handling")
        print(row)
        exchangeOption = StockAPI.exchangeOptions[row]
        textFiled.text = exchangeOption

    }


}
                        
