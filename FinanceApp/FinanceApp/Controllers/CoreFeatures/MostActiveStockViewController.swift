//
//  MostActiveStockViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-30.
//

import UIKit

class MostActiveStockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet  var tableView: UITableView!
    @IBOutlet  var lastUpdatedTimeLabel: UITextField!
    private var model :[ActiveStock] = [ActiveStock]();
    private var lastUpdatedTime = Date()
    private var lastUpdatedTimeText: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MostActiveStockViewController")
        title = "Most Active \(model.count) Stocks"
        let nib = UINib(nibName: "ActiveStockTableViewCell", bundle: nil )
        //set up table view
        tableView.register(nib, forCellReuseIdentifier: "ActiveStockTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    
        // used to handle double tap
        let doubleTapRecognizer =
           UITapGestureRecognizer(target: self,
                                  action: #selector(MostActiveStockViewController.doubleTap(_:)))
         doubleTapRecognizer.numberOfTapsRequired = 2
         self.view.addGestureRecognizer(doubleTapRecognizer)
        
        //load default data
        loadMostActiveStocks()
        self.updateTime()
        
        
    }

    //set the frame for the tableView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    //functions used to control the layout for the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveStockTableViewCell", for: indexPath) as? ActiveStockTableViewCell else { return UITableViewCell()
            
        }

        cell.configure(wtih: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.bounds.height/4.5)
    }
    
    //set the header Section to be the time it last updated
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return lastUpdatedTimeText
    }
    // function that is used to load the most active stock
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
                OperationQueue.main.addOperation {
                    self.showErrorAlert()
                    self.updateTime()
                }

                print ("Error fetching recent Stocks: \(error)")
            }
        }
        
    }
    //used to popup an alert when ever there an Error
    func showErrorAlert(){
        let alert = UIAlertController(title: "Notify", message: "There was an error getting Stock Information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel , handler: { action in
        } ))
        present(alert, animated: true)
    }
    //update date the view and the elements that depend on it 
    func updateView(newModel: [ActiveStock]){
        self.model = newModel
        self.title = "Most Active \(self.model.count) Stocks"
        self.tableView.reloadData()
        
        self.updateTime()
    }
    //used to update the variable that holds the last time the table was updated
    func updateTime(){
        lastUpdatedTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MM-dd HH:mm:s")
        let dateText = dateFormatter.string(from: lastUpdatedTime)
        lastUpdatedTimeText = "Last time updated : \(dateText)"

    }
    // our double tap handler
    @objc func doubleTap(_ gestureRecognizer: UIGestureRecognizer){
        print("double tap was pressed")
        loadMostActiveStocks()
    }

}
