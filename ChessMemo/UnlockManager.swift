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
        case loaded
        case failed
        case purchased
        case deferred
    }
    
    @Published var requestState = RequestState.loading
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
    }
}
