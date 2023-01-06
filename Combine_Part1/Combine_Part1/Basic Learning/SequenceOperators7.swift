//
//  SequenceOperators7.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 06/01/23.
//

import Foundation
import Combine

struct SequenceOperators7 {
    
    func minAndMaxOperator() {
        let publisher = [1, -45, 3, 45, 100].publisher
        
        _ = publisher
            .max()
            .sink {
                print($0)
            }
        
        _ = publisher
            .min()
            .sink {
                print($0)
            }
    }
    
    func firstAndLastOperator() {
        let publisher = ["A", "B", "C", "D"].publisher
        
        _ = publisher.first()
            .sink {
                print($0)
            }
        
        _ = publisher.first(where: {"Cat".contains($0)})
            .sink {
                print($0)
            }
        
        _ = publisher.last()
            .sink {
                print($0)
            }
    }
    
    func outputAtOperator() {
        let publisher = ["A", "B", "C", "D"].publisher
        
        _ = publisher.output(at: 2)
            .sink {
                print($0)
            }
        
        _ = publisher.output(in: (0...2))
            .sink {
                print($0)
            }
    }
    
    func countOperator() {
        let publisher = ["A", "B", "C", "D"].publisher
        let publisher1 = PassthroughSubject<Int, Never>()
        
        _ = publisher.count()
            .sink {
                print($0)
            }
        
        _ = publisher1.count()
            .sink {
                print($0)
            }
        
        publisher1.send(10)
        publisher1.send(10)
        publisher1.send(10)
        publisher1.send(10)
        // wait for the completion
        publisher1.send(completion: .finished)
    }
    
    func containsOperator() {
        let publisher = ["A", "B", "C", "D"].publisher
        
        _ = publisher.contains("C")
            .sink {
                print($0)
            }
    }
    
    func allSatisfyOperator() {
        let publisher = [1,2,3,4,5,6,7].publisher
        
        _ = publisher.allSatisfy { $0 % 2 == 0 }
            .sink {
                print($0)
            }
    }
    
    func reduceOperator() {
        let publisher = [1,2,3,4,5,6].publisher
        
        publisher.reduce(0) { accumulator, value in
            print("accumaulator: \(accumulator) and the value is \(value)")
            return accumulator + value
    
        }
    }
}
