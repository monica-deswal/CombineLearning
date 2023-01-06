//
//  AppendOperatorsPart6.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 06/01/23.
//

import Foundation
import Combine
import UIKit

class AppendOperatorsPart6 {
    
    func prependOperator() {
        let numbers = (1...5).publisher
        
        _ = numbers.prepend(100,101)
            .sink {
                print($0)
            }
        
        _ = numbers.prepend(100,100)
            .prepend(-1,-2)
            .prepend([45,67])
            .sink {
                print($0)
            }
        
        let publisher2 = (500...510).publisher
        
        _ = numbers.prepend(100,100)
            .prepend(-1,-2)
            .prepend([45,67])
            .prepend(publisher2)
            .sink {
                print($0)
            }
    }
    
    func appendOperator() {
        let numbers = (1...10).publisher
        
        _ = numbers.append(11,12)
            .append(13,14)
            .sink {
                print($0)
            }
        
        let publisher = (100...100).publisher
        
        _ = numbers.append(11,12)
            .append(13,14)
            .append(publisher)
            .sink {
                print($0)
            }
    }
    
    func switchToLatest() {
        let publisher1 = PassthroughSubject<String, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        
        let publishers = PassthroughSubject<PassthroughSubject<String, Never>, Never>()
        
        _ = publishers.switchToLatest().sink {
            print($0)
        }
        
        publishers.send(publisher1)
        
        publisher1.send("Publisher 1 - Value 1")
        publisher1.send("Publisher 1 - Value 2")
        
        publishers.send(publisher2) // Switching to publisher 2
        
        publisher2.send("Publisher 2 - Value 1")
        publisher2.send("Publisher 2- Value 2")
        
        //Not work
        publisher1.send("Publisher 1 - Value 3")
        
    }
    
    let images = ["image1", "image2", "image3", "image4", "image5"]
    var index = 0
    
     func switchToLatestExample2() {
        let taps = PassthroughSubject<Void, Never>()
         _ = taps.map { _ in self.getImage()}
            .switchToLatest().sink {
                print($0)
            }
        
        taps.send()
        
         // replace from 6.0 to 6.5
        DispatchQueue.global().asyncAfter(deadline: .now() + 6.0) {
            self.index += 1
            taps.send()
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 6.5) {
            self.index += 1
            taps.send()
        }
    }
    
    func getImage() -> AnyPublisher<UIImage?, Never> {
        
        return Future<UIImage?, Never> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                promise(.success(UIImage(named: self.images[self.index])))
            }
        }.map { $0}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func mergeOperator() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<Int, Never>()
        
       let _ = publisher1.merge(with: publisher2).sink {
            print($0)
        }
        
        publisher1.send(10)
        publisher1.send(11)
        
        publisher2.send(12)
        publisher2.send(13)
        
    }
    
    func combineLatestOperator() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        
        _ = publisher1.combineLatest(publisher2)
            .sink {
            print("P1: \($0), P2: \($1)")
        }
        
        publisher1.send(1)
        publisher2.send("A")
        publisher2.send("B")
    }
    
    func zipOperator() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        
        _ = publisher1.zip(publisher2)
            .sink {
                print("P1: \($0), P2: \($1)")
            }
        
        publisher1.send(1)
        
        // Waiting for its partner
        publisher1.send(3)
        
        publisher2.send("2")
    }
}
