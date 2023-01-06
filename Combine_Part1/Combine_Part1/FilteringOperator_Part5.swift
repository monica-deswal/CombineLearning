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
        let strings = ["a", "1.24", "b", "3.45", "6.7", "d"].publisher
            .compactMap{ Float($0)}.sink {
                print($0)
            }
    }
    
    func ignoreOutputOperator() {
        let number = (1...5000).publisher
        
        // output only completion value
       let cancellableSubscriber = number.ignoreOutput().sink(receiveCompletion: { print($0)}) { print($0)}
    }
    
    func firstOperator() {
        let numbers = (1...9).publisher
        
        // finds the first condition is met, break after that
        let cancellableSubcriber = numbers.first(where: { $0 % 2 == 0})
            .sink {
                print($0)
            }
    }
    
    func lastOperator() {
        let numbers = (1...9).publisher
        
        // finds the last value fom  condition is met, break after that
        let cancellableSubcriber = numbers.last(where: { $0 % 2 == 0})
            .sink {
                print($0)
            }
    }
    
    func dropFirstOperator() {
        let number = (1...10).publisher
        
            // can be used for pagination
        number.dropFirst(5)
            .sink {
                print($0)
            }
    }
    
    func dropWhileOperator() {
        let number = (1...10).publisher
        
        number.drop(while: {$0 % 3 != 0})
            .sink {
                print($0)
       }
        
        let value = ["A", "B", nil, "C"].publisher
        
       let cancellablePublisher = value.drop(while: {$0 != nil})
            .sink {
                print($0)
            }
    }
    
    func dropUntillOperator() {
        
    }
    
}

