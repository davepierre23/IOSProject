//
//  StockProfileTableViewCell.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-31.
//

import UIKit

class StockProfileTableViewCell: UITableViewCell {

    @IBOutlet var companyImage: UIImageView?;
    @IBOutlet var companyNameLabel : UILabel! ;
    @IBOutlet var currencyLabel : UILabel! ;
    @IBOutlet var currentPriceLabel : UILabel! ;
    @IBOutlet var  dividendLabel : UILabel!;
    @IBOutlet var exchangeNameLabel : UILabel! ;
    @IBOutlet var sectorLabel : UILabel! ;
    @IBOutlet var industryLabel : UILabel! ;
    
    static let identifier = "StockProfileTableViewCell"

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
         companyImage?.image = model.image
        companyNameLabel.text = "Company \(model.companyName)"
        currencyLabel.text = "Found in : \(model.country) (\(model.exchange))"
       sectorLabel.text = "Sector: \(model.sector)"
        industryLabel.text = "Industry: \(model.industry)"
        currentPriceLabel.text = "Price: $\(model.currentPrice) \(model.changeInPrice)"
        dividendLabel.text = "Dividend Pay : \(model.dividend)"
        
    }

}
