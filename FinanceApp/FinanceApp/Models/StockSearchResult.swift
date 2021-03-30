//
//  StockSearchResult.swift
//  FinanceApp
//
//  Created by Dave Pierre on 2021-03-29.
//


//used to model a StockSearchResult
//example
/*
"symbol" : "PAA",
 "name" : "Plains All American Pipeline, L.P.",
 "currency" : "USD",
 "stockExchange" : "Nasdaq Gloabl Select",
 "exchangeShortName" : "NASDAQ
 */
class StockSearchResult {
    let symbol: String
    let name: String
    let currency: String
    let stockExchange: String
    var exchangeShortName: String
    
    init(symbol: String, name: String, currency: String, stockExchange: String, exchangeShortName : String ) {
        self.symbol = symbol
        self.name = name
        self.currency = currency
        self.stockExchange=stockExchange
        self.exchangeShortName = exchangeShortName
    }
}
