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
        print("SearchTickerViewController");
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
    // when user has click search make a search request and update the UI
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let query = searchController.searchBar.text else{
            return
        }
        // empty the sarch bar text field 
        searchController.searchBar.text = ""
        let exchange = exchangeOption
        
        //make the request only if the query is greater then 0
        if (query.count > 0){
            searchStock(query: query, exchange: exchange)

        }
    }
    
    // number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    //configure each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockSearchResultsTableViewCell", for: indexPath) as? StockSearchResultsTableViewCell else { return UITableViewCell()
            
        }
        //set up a cell based on a stock search result
        cell.configure(wtih: model[indexPath.row])
        return cell
    }
    //the height of the table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.bounds.height/4.5)
    }
    //used to get the UI infromation and make the request
    func searchStock(query:String, exchange: String){
        let stockStore = StockStore()
        stockStore.fetchStockResults(query: query, exchange: exchange, completion: { stockSearchResults in
            switch stockSearchResults {
            case let .success(stockSearchResults):
                //update the UI if the new infromation
                print("Successfully found \(stockSearchResults.count) Stocks.")
                OperationQueue.main.addOperation {
                    self.updateView(newModel: stockSearchResults)
                }
            //PRODUCE AN ERROR MESSAGE TO USER
            case let .failure(error):
                print ("Error fetching recent Stocks: \(error)")
                OperationQueue.main.addOperation {
                    self.showErrorAlert()
                }
            }
        })
    }
    //used to update the view
    func updateView(newModel : [StockSearchResult]){
        
        self.model = newModel
        //set the results label dynamicially
        if(self.model.count>0){
            resultsLabel.text = "Number of Results \(self.model.count)"
        }else{
            resultsLabel.text = "No Results"
        }
        self.tableView.reloadData()
        
    }
    
    //used to present an alert box to notify that user could not pull a stock
    func showErrorAlert(){
        let alert = UIAlertController(title: "Notify", message: "There was an error getting Stock Information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel , handler: { action in
        } ))
        present(alert, animated: true)
    }
    
    //used to select a exchange or type of security
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
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.closeDropDown))
        //added the button to the toolbar
        exchangeOptionToolBar.setItems([doneButton], animated: true)
        exchangeOptionToolBar.isUserInteractionEnabled = true
        exchangeOptionView.inputAccessoryView = exchangeOptionToolBar
    }
    
    //used to close the drop down menu when finshed
    @objc func closeDropDown() {
          view.endEditing(true)
    }
 
    
}
                        
