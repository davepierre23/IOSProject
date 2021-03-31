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
    @IBOutlet var  exchangeOptionView: UITextField!
    @IBOutlet var resultsLabel: UITextField!

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
        exchangeOptionView.delegate = self
        exchangeOptionView.text = exchangeOption
        createExchangeOptionView()
        closeExchangeOptionHandler()
        self.updateView(newModel : self.model)
        resultsLabel.delegate = self

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController

      
    }

        
    //used to make the text field componentes not editable
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let query = searchController.searchBar.text else{
            return
        }
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
                    self.updateView(newModel: stockSearchResults)
                }

            case let .failure(error):
                print ("Error fetching recent Stocks: \(error)")
            }

        })
    }
    func updateView(newModel : [StockSearchResult]){
        
        self.model = newModel
        resultsLabel.text = "Number of Results \(self.model.count)"
        self.tableView.reloadData()
        
    }
    
    
    //used for as DropDownComponent to search for a exchange
    func createExchangeOptionView() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
        exchangeOptionView.inputView = pickerView
    }
    //used to close the DropDownCompoent view
    func closeExchangeOptionHandler() {
        //create a tool bar to add a button so when we have selected an option we can press the down button
       let exchangeOptionToolBar = UIToolbar()
        exchangeOptionToolBar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        //added the button to the toolbar
        exchangeOptionToolBar.setItems([doneButton], animated: true)
        exchangeOptionToolBar.isUserInteractionEnabled = true
        exchangeOptionView.inputAccessoryView = exchangeOptionToolBar
    }
    //used to close the drop down menu when finshed
    @objc func action() {
          view.endEditing(true)
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
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        exchangeOption = StockAPI.exchangeOptions[row]
        exchangeOptionView.text = exchangeOption

    }
    
 

}
                        
