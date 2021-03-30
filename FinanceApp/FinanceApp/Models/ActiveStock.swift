//
//  ActiveStock.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-29.
//

import Foundation
/*
{
  "ticker" : "BRK-A",
  "changes" : 2291.75,
  "price" : "390287",
  "changesPercentage" : "(+0.59%)",
  "companyName" : "Berkshire Hathaway Inc"
},
*/

//MODEL to sed to populate this end point
//End we will use  https://financialmodelingprep.com/api/v3/actives?apikey=40d61e33f3a413f1c52d3cd0fe1c814e
struct ActiveStock {
      let ticker : String;   // used to save the ticker symbol
      let changesPercentage : String
      let price : String;
      let changes : Double;
      let companyName : String;
    
    //used to popluate the Stock Profile model
    init?(ticker: String, changesPercentage: String, price: String, companyName: String, changes : Double ) {
  
        self.ticker = ticker
        self.changesPercentage = changesPercentage
        self.price = price
        self.changes = changes
        self.companyName = companyName


    }

}
