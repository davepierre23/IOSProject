//
//  StockProfile.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-29.
//

import Foundation
import UIKit

//https://financialmodelingprep.com/api/v3/profile/AAPL?apikey=40d61e33f3a413f1c52d3cd0fe1c814e
//used to model a StockProfile
//example
/*
 [ {
   "symbol" : "AAPL",
   "price" : 121.507,
   "beta" : 1.33758,
   "volAvg" : 110668308,
   "mktCap" : 2039873400000,
   "lastDiv" : 0.82,
   "range" : "59.225-145.09",
   "changes" : 0.2971,
   "companyName" : "Apple Inc",
   "currency" : "USD",
   "cik" : "0000320193",
   "isin" : "US0378331005",
   "cusip" : "037833100",
   "exchange" : "Nasdaq Global Select",
   "exchangeShortName" : "NASDAQ",
   "industry" : "Consumer Electronics",
   "website" : "https://www.apple.com/",
   "description" : "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. It also sells various related services. The company offers iPhone, a line of smartphones; Mac, a line of personal computers; iPad, a line of multi-purpose tablets; and wearables, home, and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, HomePod, iPod touch, and other Apple-branded and third-party accessories. It also provides AppleCare support services; cloud services store services; and operates various platforms, including the App Store, that allow customers to discover and download applications and digital content, such as books, music, video, games, and podcasts. In addition, the company offers various services, such as Apple Arcade, a game subscription service; Apple Music, which offers users a curated listening experience with on-demand radio stations; Apple News+, a subscription news and magazine service; Apple TV+, which offers exclusive original content; Apple Card, a co-branded credit card; and Apple Pay, a cashless payment service, as well as licenses its intellectual property. The company serves consumers, and small and mid-sized businesses; and the education, enterprise, and government markets. It sells and delivers third-party applications for its products through the App Store. The company also sells its products through its retail and online stores, and direct sales force; and third-party cellular network carriers, wholesalers, retailers, and resellers. Apple Inc. was founded in 1977 and is headquartered in Cupertino, California.",
   "ceo" : "Mr. Timothy Cook",
   "sector" : "Technology",
   "country" : "US",
   "fullTimeEmployees" : "147000",
   "phone" : "14089961010",
   "address" : "1 Apple Park Way",
   "city" : "Cupertino",
   "state" : "CALIFORNIA",
   "zip" : "95014",
   "dcfDiff" : 89.92,
   "dcf" : 127.377,
   "image" : "https://financialmodelingprep.com/image-stock/AAPL.png",
   "ipoDate" : "1980-12-12",
   "defaultImage" : false,
   "isEtf" : false,
   "isActivelyTrading" : true
 } ]
 */
//MODEL to sed to populate this end point
//End we will use  https://financialmodelingprep.com/api/v3/profile/CU.TO?apikey=40d61e33f3a413f1c52d3cd0fe1c814e
class StockProfile {
      let symbol : String;   // used to save the ticker symbol
      let exchange : String
      let country : String;
     let  companyName : String;   // used to save company name
      let  photoURl : URL; // used to dave the image url
      let sector : String ;
      let industry : String;
      var changeInPrice : Double ;
      var currentPrice : Double ;
      let beta : Double;
      let dividend : Double;
     var image: UIImage?

    
    
    
    //used to popluate the Stock Profile model
    init?(symbol: String, exchange: String, country: String,   companyName : String, photoURl: URL, sector: String, industry: String , changeInPrice:Double , currentPrice: Double,
          beta: Double, dividend: Double ) {
        
        
        
        self.symbol = symbol
        self.exchange = exchange
        self.dividend = dividend
        self.beta = beta
        self.country = country
        self.companyName = companyName
        self.industry = industry
        self.photoURl = photoURl
        self.sector = sector
        self.currentPrice = currentPrice
        self.changeInPrice = changeInPrice
        

    }
    

}
