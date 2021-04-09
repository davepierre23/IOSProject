//
//  StockStore.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-09.
//  Copyright © 2021 COMP2601. All rights reserved.
//


import Foundation
import UIKit

//class that is used to make a netwrokf request to the stock api
class StockStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
   //used to make a network request to get the stock profile
  func fetchStockProfile(ticker: String ,completion: @escaping (StockProfileResult) ->Void){
        let url = StockAPI.getStockProfile(ticker: ticker)
        //create a Network request to the API
        print("the url \(url)")
        let request = URLRequest(url: url)
          let task = session.dataTask(with: request){
              (data, response, error) -> Void in

              let result = self.processStockProfileRequest(data: data, error: error)
              completion(result)
          }
        task.resume()
    }
    //used to process the network request and convert it to an stockprofile objects array
    func processStockProfileRequest(data: Data?, error: Error?) -> StockProfileResult {
        guard let jsonData:Data = data
        else {
            return .failure(error!)
        }
        return StockAPI.searchStockProfile(fromJSON: jsonData)
    }
    //used to make a network request to get most active stocks
    func fetchMostActiveStocks(completion: @escaping (ActiveStockResults) ->Void){
        let url = StockAPI.getMostActives()
        print("the url \(url)")
        let request = URLRequest(url: url)
          let task = session.dataTask(with: request){
              (data, response, error) -> Void in
              let result = self.processMostActiveStockRequest(data: data, error: error)
              completion(result)
          }
          task.resume()
      }
    //used to parse the most active stock after the request is made
    func processMostActiveStockRequest(data: Data?, error: Error?) -> ActiveStockResults {
        guard let jsonData:Data = data
        else {
            return .failure(error!)
        }
        return StockAPI.mostActiveStocks(fromJSON: jsonData)
    }
    
    //used to make a network request to get the search stock results. make a request using the query string and which exchange to look for
    func fetchStockResults(query: String, exchange: String, completion: @escaping (StockSearchResults) ->Void){
        let url = StockAPI.searchTicker(query: query, exchange: exchange)
        //create a Network request to the API
        print("the url \(url)")
        let request = URLRequest(url: url)
          let task = session.dataTask(with: request){
              (data, response, error) -> Void in
              let result = self.processStockSearchRequest(data: data, error: error)
              completion(result)
          }
        task.resume()
    }
    //used to process a stock search request to convert into  object
    func processStockSearchRequest(data: Data?, error: Error?) -> StockSearchResults {
        guard let jsonData:Data = data
        else {
            return .failure(error!)
        }
        return StockAPI.stockSearchResults(fromJSON: jsonData)
    }

    //used to fetch an image for the sotck logo
    func fetchImage(for stock: StockProfile, completion: @escaping (ImageResult)->Void){
        let photoURL = stock.photoURl
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            completion(result)

        }
        task.resume()
    }
    //process the the image request for a stock logo
    private func processImageRequest(data: Data?, error: Error?) ->ImageResult {
            guard
            let imageData = data,
            let image = UIImage(data: imageData)
            else {
                //could not create image
                if data == nil { return .failure(error!) }
                else {return .failure(StockPhotoError.imageCreationError) }
            }
            return .success(image)
        }
}

