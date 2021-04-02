//
//  StockSearchResultsTableViewCell.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-31.
//

import UIKit

class StockSearchResultsTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel : UILabel! ;
    @IBOutlet var exchangeNameAndCurrencyLabel : UILabel! ;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(wtih model: StockSearchResult ){
        //set the labels of the fields
        nameLabel.text = "\(model.name) (\(model.symbol))"
        exchangeNameAndCurrencyLabel.text = "Exchange Found : \(model.stockExchange)\n Currency: \(model.currency)"

    }
  
}
