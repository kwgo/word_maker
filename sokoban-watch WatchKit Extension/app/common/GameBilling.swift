//
//  GameBilling.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-26.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import Foundation
import StoreKit


class GameBilling: NSObject, SKPaymentTransactionObserver {
    
    let VERIFY_RECEIPT_URL = "https://buy.itunes.apple.com/verifyReceipt"
    let ITMS_SANDBOX_VERIFY_RECEIPT_URL = "https://sandbox.itunes.apple.com/verifyReceipt"
    
    var productDict: Dictionary<String, SKProduct>!
    //var emptyDict: [String: String] = [:]
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
        requestProducts() //request product list
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    
    // triger by purchase
    func onSelectRechargePackages(productId: String) {
        // check if it is supprot in app purchase
        if(SKPaymentQueue.canMakePayments()) {
            print("============in app purchase supported.")
            payProduct(product: productDict[productId]!)
        }
        else{
            print("============in app purchase not supported.")
        }
    }
    
    // request product list
    func requestProducts() {
        let products: Set = ["productId1","productId2","productId3"]
        let request = SKProductsRequest(productIdentifiers: products)
        request.start()
    }
    
    // requestProducts call back
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if (productDict == nil) {
            productDict = Dictionary(minimumCapacity: response.products.count)
        }
        
        for product in response.products {
            print("=======product id=======\(product.productIdentifier)")
            print("===product title ==========\(product.localizedTitle)")
            print("====product description==========\(product.localizedDescription)")
            print("=====product price =========\(product.price)")
            
            // add into products dictionary
            productDict.updateValue(product, forKey: product.productIdentifier)
        }
    }
    
    func payProduct(productId: String) {
        if(productDict != nil) {
            guard let product = productDict[productId] else {
                return
            }
            payProduct(product: product)
        } else {
             print("not ready!")
        }
    }
    
    // pay product
    func payProduct(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if (SKPaymentTransactionState.purchased == transaction.transactionState) {
                print("payment success＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
                // verify receipt
                // self.verifyPruchase()
                paymentSuccess()
                // remove the transaction form the queue
                SKPaymentQueue.default().finishTransaction(transaction)
            }
            else if(SKPaymentTransactionState.failed == transaction.transactionState) {
                print("payment fail＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
                paymentFailure()
                SKPaymentQueue.default().finishTransaction(transaction)
            }
            else if (SKPaymentTransactionState.restored == transaction.transactionState) {
                //  this is the restore purchase, not for resume?
                SKPaymentQueue.default().finishTransaction(transaction )
            }
        }
    }
    
    func verifyPruchase() {
        // varify the reciprt
        // appStoreReceiptURL iOS7.0 new, after purchase, store recipts on the url
        let receiptURL = Bundle.main.appStoreReceiptURL
        // get recipt data
        let receiptData = NSData(contentsOf: receiptURL!)
        
        //let url = NSURL(string: VERIFY_RECEIPT_URL)
        let url = NSURL(string: ITMS_SANDBOX_VERIFY_RECEIPT_URL)
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        
        let encodeStr = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
        
        let payload = NSString(string: "{\"receipt-data\" : \"" + encodeStr! + "\"}")
        print(payload)
        let payloadData = payload.data(using: String.Encoding.utf8.rawValue)
        
        request.httpBody = payloadData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
            print("Response: \(String(describing: response))")
            do {
                let dict = try JSONSerialization.jsonObject(with: data!)
                // check the following data in the dictionary
                // bundle_id&application_version&product_id&transaction_id
                // verify success
                print(dict as Any)
            } catch {
                GameLogger.error("verify pruchase error: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    func restorePurchase(){
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentSuccess() {
    }
    
    func paymentFailure() {
    }
}
