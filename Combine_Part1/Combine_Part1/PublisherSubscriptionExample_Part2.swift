//
//  PublisherSubscriptionExample_Part2.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import Foundation
import Combine

class StringSubsriber: Subscriber {
  
    typealias Input = String
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        print("Received subscription")
        subscription.request(.max(3))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received value", input)
        //return .none
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
}

struct PublisherSubscriptionExample_Part2 {
    
    func subscriberExample1() {
        
        let publisher = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"].publisher
        
        let subscriber = StringSubsriber()
        
        publisher.subscribe(subscriber)
        
    }
}
