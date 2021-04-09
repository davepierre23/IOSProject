//
//  StockProfilesTableViewCell.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-31.
//

import UIKit

class StockProfilesTableViewCell: UITableViewCell {

    @IBOutlet var companyImage: UIImageView?;
    @IBOutlet var companyNameLabel : UILabel! ;
    @IBOutlet var currencyLabel : UILabel! ;
    @IBOutlet var changeInPriceLabel : UILabel! ;
    @IBOutlet var currentPriceLabel : UILabel! ;
    @IBOutlet var  dividendLabel : UILabel!;
    @IBOutlet var exchangeNameLabel : UILabel! ;
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(wtih model: StockProfile ){
        //set the labels of the fields
        
        companyImage = model.image
//        companyNameLabel.text = "Company \(model.companyName)"
//        currencyLabel.text = "Country: \(model.country)"
//        changeInPriceLabel.text = "\(model.changeInPrice)"
//        currentPriceLabel.text = "Price: \(model.country)"
//        dividendLabel.text = "Dividend Pay : \(model.country)"
//        exchangeNameLabel.text = "Exchange Name: \(model.country)"
//
        
    }
}
