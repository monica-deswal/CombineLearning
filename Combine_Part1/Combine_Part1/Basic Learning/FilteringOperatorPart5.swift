//
//  FilteringOperator_Part5.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import Foundation
import Combine

struct FilteringOperator_Part5 {
    
    //MARK: We use the filter operator if we want to accept only those elements that match a certain condition.
    func filterOperator() {
        
        let numbers = (1...20).publisher
        
        _ = numbers
            .filter { $0 % 2 == 0 }
            .sink {
                print($0)
            }
    }
    
    //MARK: The remove duplicate operator, as its name implies allow us the obtain only unique values.
    func removeDuplicates() {
        let words = "apple apple fruit apple mango watermelon apple".components(separatedBy: " ").publisher
        let cancellableSubscriber = words
            .removeDuplicates()
            .sink {
                print($0)
            }
        
        cancellableSubscriber.cancel()
    }
    
    //MARK: Compact map allows us to obtain only non-nil values.
    func compactMap() {
        let _ = ["a", "1.24", "b", "3.45", "6.7", "d"].publisher
            .compactMap{ Float($0)}.sink {
                print($0)
            }
    }
    
    //MARK: Ignoreoutput operator ignores all upstream events. However, it passes along a completion state(finished or failed). It is useful in cases when you don't care about values and only need to know if a publisher had finished.
    func ignoreOutputOperator() {
        let number = (1...5000).publisher
        
        // output only completion value
       let _ = number.ignoreOutput()
                     .sink(receiveCompletion: { print($0)}) { print($0)}
    }
    
    //MARK: Use the .first(where:) operator to obtain the first value that matches our criteria in a subscripion
    func firstOperator() {
        let numbers = (1...9).publisher
        
        // finds the first condition is met, break after that
        let _ = numbers.first(where: { $0 % 2 == 0})
            .sink {
                print($0)
            }
    }
    
    //MARK: Use the .last(where:) operator to obtain the last value that matches our criteria in a subscripion
    func lastOperator() {
        let numbers = (1...9).publisher
        
        // finds the last value fom  condition is met, break after that
        let _ = numbers.last(where: { $0 % 2 == 0})
            .sink {
                print($0)
            }
    }
    
    //MARK: dropFirst operator allows us to disregard a number of elements we pass as a parameter.
    func dropFirstOperator() {
        let number = (1...10).publisher
        
            // can be used for pagination
        let _ = number.dropFirst(5)
            .sink {
                print($0)
            }
    }
    
    //MARK: DropWhile operator disregard elements untill the given predicate is not satisfied.
    func dropWhileOperator() {
        let number = (1...10).publisher
        
       let _ = number.drop(while: {$0 % 3 != 0})
            .sink {
                print($0)
       }
        
        let value = ["A", "B", nil, "C"].publisher
        
       let _ = value.drop(while: {$0 != nil})
                .sink {
                    print($0 ?? "")
            }
    }
    
    //MARK: We use this version of the .drop operator, when we want to have a "trigger" publisher that allows the source publisher to emit values. Once a value is sent onto the "trigger" publisher, the source publisher is allowed to execute.
    func dropUntillOutputFromOperator() {
        let isReady = PassthroughSubject<Void, Never>()
        let taps = PassthroughSubject<Int, Never>()
        
        _ = taps.drop(untilOutputFrom: isReady).sink {
            print($0)
        }
        
        // it is dropped untill we get the output from ready
        (1...10).forEach { n in
            taps.send(n)
            
            if n == 3 {
                isReady.send()
            }
        }
    }
    
    //MARK: Prefix operator is a publisher that publishes up to specified number of elements. Use prefix(_:) to limit the number of elements rebuplished to downstream subscriber.
    
    func prefixOperator() {
        
        let numbers = (1...10).publisher
        
        _ = numbers.prefix(2).sink {
            print($0)
        }
        
        _ = numbers.prefix(while: { $0 < 3}).sink {
            
            print($0)
        }
    }
    
}

