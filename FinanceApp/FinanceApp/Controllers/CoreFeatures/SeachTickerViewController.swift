//
//  SeachTickerViewController.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-20.
//

import UIKit

class SeachTickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // how much cells to return
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    // dequeue a cell and return that cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = "CELL \(indexPath.row+1)"
        return cell
    }

}
