//
//  StockAPI.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-09.
//  Copyright © 2021 COMP2601. All rights reserved.
//

import Foundation
import UIKit


//used to recieve the StockPhoto
enum StockPhotoError: Error {
    case imageCreationError
}

//used for the StockProfile
enum StockProfileResult {
    case success([StockProfile])
    case failure(Error)
}
//to change for Stock Search and motive actives
enum StockSearchResults {
    case success([StockSearchResult])
    case failure(Error)
}

//to change for Stock Search and motive actives
enum ActiveStockResults {
    case success([ActiveStock])
    case failure(Error)
}


enum ImageResult {
    case success(UIImage)
    case failure(Error)
}


enum FinancialModelError: Error {
    case invalidJSONData
}

class StockAPI {
    //used to get infromation from an API
    //https://financialmodelingprep.com/developer/docs/
    private static let finanaceModelbaseURLString = "https://financialmodelingprep.com"
    private static let financeModelAPIKEY="40d61e33f3a413f1c52d3cd0fe1c814e"
    
    //options found under the Ticker Search
    public static let exchangeOptions = ["ETF", "MUTUAL_FUND", "COMMODITY" ,"INDEX","CRYPTO", "FOREX", "TSX" , "AMEX" , "NASDAQ" , "NYSE" , "EURONEXT", "XETRA","NSE" ,"LSE"]
   //different method that are availble in the API
   enum Method : String {
    case  SYMBOL_SEARCH =  "/api/v3/search"
    case  MOST_ACTIVES =  "/api/v3/actives"
    case  STOCK_SCREENER =  "/api/v3/stock-screener"
    case  STOCK_PROFILE =  "/api/v3/profile/"
    }
    

    private static func convertToURL(path: String?,parameters: [String:String]?) -> URL {

      var components = URLComponents(string: finanaceModelbaseURLString)!
      components.path = path ?? ""
      var queryItems = [URLQueryItem]()
     
      if let additionalParams = parameters {
         for(key, value) in additionalParams {
             let item = URLQueryItem(name: key, value: value)
             queryItems.append(item)
         }
         
      }

      components.queryItems = queryItems

      return components.url!
    }
     
    //function used to search for a ticker
    // example of request :https://financialmodelingprep.com/api/v3/search-ticker?query=AA&limit=10&exchange=NASDAQ&apikey=40d61e33f3a413f1c52d3cd0fe1c814e
    public static func searchTicker(query: String, exchange: String)-> URL{
          return convertToURL(
            path: Method.SYMBOL_SEARCH.rawValue,
             parameters: [
            "query": query,
            "limit" : "10",
            "exchange": exchange,
             "apikey": financeModelAPIKEY,
             ])
     }
     //function used to return the top actives stocks
     // example of request : https://financialmodelingprep.com/api/v3/actives?apikey=40d61e33f3a413f1c52d3cd0fe1c814e
     static func getMostActives()-> URL{
          return convertToURL(
            path: Method.MOST_ACTIVES.rawValue,
             parameters: [
             "apikey": financeModelAPIKEY,
             ])
     }
    

    //function used to get the profile of a stock
    // example : https://financialmodelingprep.com/api/v3/profile/AAPL?apikey=40d61e33f3a413f1c52d3cd0fe1c814e
    public static func getStockProfile(ticker : String ) -> URL {
        return convertToURL(
            path: Method.STOCK_PROFILE.rawValue + ticker,
             parameters: [
             "apikey": financeModelAPIKEY,
             ])
    }
    
    private static func stockSearchResult(fromJSON json: [String:Any]) -> StockSearchResult? {
         guard
           let symbol = json["symbol"] as? String,
           let name = json["name"] as? String,
           let currency = json["currency"] as? String,
           let stockExchange = json["stockExchange"] as? String,
           let exchangeShortName = json["exchangeShortName"] as? String
          
         else {
             //Did not have all the info fields to create a stockSearch Results
             return nil
         }
         
         return StockSearchResult(symbol: symbol, name: name, currency: currency, stockExchange: stockExchange, exchangeShortName : exchangeShortName )
     }
    

    
    static func stockSearchResults(fromJSON data: Data) -> StockSearchResults {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonObject)
            if let activeStocksArray = jsonObject as? [[String : Any]]{
                for object in activeStocksArray {
                        // access all objects in array
                    print(object)
                    }

            }
            guard
                let stockResults = jsonObject as? [[String : Any]]
            else {
                    //Unexpected JSON structure
                    return .failure(FinancialModelError.invalidJSONData)
            }
            //iterate through the list of Stock results and add to the lists
            var finalStockResults = [StockSearchResult]();
            for stockResultJson in stockResults {
                if let stockResult = stockSearchResult(fromJSON: stockResultJson){
                    finalStockResults.append(stockResult)
                }
            }
            
            if finalStockResults.isEmpty && !stockResults.isEmpty {
                //Not able to parse the Stock API data
                //Maybe the JSON format for photos has changed
                return .failure(FinancialModelError.invalidJSONData)
            }
            return .success(finalStockResults)
        }
        catch let error {
            return .failure(error)
        }
    }
    private static func mostActiveStock(json: [String:Any]) -> ActiveStock? {
        guard
           let ticker = json["ticker"] as? String,
           let changesPercentage = json["changesPercentage"] as? String,
           let price = json["price"] as? String,
           let companyName = json["companyName"] as? String,
           let changes = json["changes"] as? Double
          
         else {
             //Did not have all the info fields to create a stockSearch Results
             return nil
         }
         
        return ActiveStock(ticker: ticker, changesPercentage: changesPercentage, price: price, companyName: companyName, changes : changes )
     }

    static func mostActiveStocks(fromJSON data: Data) -> ActiveStockResults {
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let activeStocksArray = jsonObject as? [[String : Any]]
             
            else {
                    //Unexpected JSON structure
                    return .failure(FinancialModelError.invalidJSONData)
            }
            //iterate through the list of Stock results and add to the lists
            var finalActiveStockResults = [ActiveStock]();
            for activeStock in activeStocksArray {
                if let stockResult = mostActiveStock(json: activeStock){
                    finalActiveStockResults.append(stockResult)
                }
            }
            
            if finalActiveStockResults.isEmpty && !activeStocksArray.isEmpty {
                //Not able to parse the Stock API data
                //Maybe the JSON format for photos has changed
                return .failure(FinancialModelError.invalidJSONData)
            }
            return .success(finalActiveStockResults)
        }
        catch let error {
            return .failure(error)
        }
    }
    static func stockProfile(json: [String:Any] )-> StockProfile? {
        
        guard let symbol = json["symbol"] as? String,
                let exchange = json["exchangeShortName"] as? String,
              let dividend = json["lastDiv"] as? Double,
                let beta = json["beta"] as? Double,
                let companyName = json["companyName"] as? String,
                let country = json["country"] as? String,
                let photoURl = json["image"] as? String,
                let url = URL(string: photoURl),
                let sector = json["sector"] as? String,
                let industry = json["industry"] as? String,
                let currentPrice = json["price"] as? Double,
                let changeInPrice = json["changes"] as? Double
            else {
            print("Stock profile")
                return nil
            }
         
        return StockProfile(symbol: symbol, exchange: exchange, country: country,  companyName : companyName, photoURl: url, sector: sector, industry: industry , changeInPrice:changeInPrice, currentPrice: currentPrice,
    beta: beta, dividend: dividend )

    }
    
    static func searchStockProfile(fromJSON data: Data) -> StockProfileResult {
     
        do {

            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let stockProfileResults = jsonObject as? [[String : Any]]
            else {
                    //Unexpected JSON structure
                    return .failure(FinancialModelError.invalidJSONData)
            }
            //iterate through the list of Stock results and add to the lists
            var stockProfiles = [StockProfile]();
            for aProfile in stockProfileResults {
                if let stockResult = stockProfile(json: aProfile){
                    stockProfiles.append(stockResult)
                }
            }
            if stockProfileResults.isEmpty && stockProfiles.isEmpty {
                //Not able to parse the Stock API data
                //Maybe the JSON format for photos has changed
                return .failure(FinancialModelError.invalidJSONData)
            }
            return .success(stockProfiles)
        }
        catch let error {
            return .failure(error)
        }
    }
}



