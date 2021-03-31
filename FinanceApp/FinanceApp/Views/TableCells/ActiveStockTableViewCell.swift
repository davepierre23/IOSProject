//
//  ActiveStockTableViewCell.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-31.
//

import UIKit

class ActiveStockTableViewCell: UITableViewCell {
    @IBOutlet var companyNameLabel : UILabel! ;
    @IBOutlet var tickerLabel : UILabel! ;
    @IBOutlet var changesLabel : UILabel! ;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    public func configure(wtih model: ActiveStock ){
        //set the labels of the fields
        companyNameLabel.text = "\(model.companyName) ($\(model.price))"
        tickerLabel.text = model.ticker
        changesLabel.text = model.changesPercentage
        
        //check to see if the price has change or not
        if(model.changesPercentage.contains("+")){
                backgroundColor = .green
            }else{
                backgroundColor = .red
        }
  
   

    }
    
}
