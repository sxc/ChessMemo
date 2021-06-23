//
//  UnlockManager.swift
//  ChessMemo
//
//  Created by Xiaochun Shen on 2021/6/18.
//

import Foundation
import StoreKit
import SwiftUI

class UnlockManager: NSObject, ObservableObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    enum RequestState {
        case loading
        case loaded(SKProduct)
        case failed(Error?)
        case purchased
        case deferred
    }
    
    private enum StoreError: Error {
        case invalidIdentifiers, missingProduct
    }
    
    @Published var requestState = RequestState.loading
    
    private let dataController: DataController
    private let request: SKProductsRequest
    private var loadedProducts = [SKProduct]()
    
    init(dataController: DataController) {
        self.dataController = dataController
        
        let productIDs = Set(["com.shenxiaochun.ChessMemo.unlock"])
        request = SKProductsRequest(productIdentifiers: productIDs)
        
        super.init()
        
        SKPaymentQueue.default().add(self)
        request.delegate = self
        request.start()
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.loadedProducts = response.products
            
            guard let unlock = self.loadedProducts.first else {
                self.requestState = .failed(StoreError.missingProduct)
                return
            }
            
            if response.invalidProductIdentifiers.isEmpty == false {
                print("Alert: Received invalid product identifiers: \(response.invalidProductIdentifiers)")
                      self.requestState = .failed(StoreError.invalidIdentifiers)
                      return
            }
            
            self.requestState = .loaded(unlock)
            
        }
        
    }
    
    func buy(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}
