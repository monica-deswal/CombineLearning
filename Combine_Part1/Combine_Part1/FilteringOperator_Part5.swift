//
//  FilteringOperator_Part5.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import Foundation

struct FilteringOperator_Part5 {
    
    func filterOperator() {
        
        let numbers = (1...20).publisher
        
        numbers
            .filter { $0 % 2 == 0 }
            .sink {
                print($0)
            }
    }
    
    func removeDuplicates() {
        let words = "apple apple fruit apple mango watermelon apple".components(separatedBy: " ").publisher
        let cancellableSubscriber = words
            .removeDuplicates()
            .sink {
                print($0)
            }
        
        cancellableSubscriber.cancel()
    }
    
    func compactMap() {
        
    }
}

