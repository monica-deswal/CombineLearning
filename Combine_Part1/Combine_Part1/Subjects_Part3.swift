//
//  Subjects_Part3.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import Foundation
import Combine

//Subjects
 // - Publisher
 // - Subscriber

enum SubjectError: Error {
    case subscriberError
}


struct SubjectsStringSubscriber: Subscriber {
    
    var combineIdentifier: CombineIdentifier
    
    typealias Input = String
    typealias Failure = SubjectError
    
    func receive(subscription: Subscription) {
        print("Received subscription")
        subscription.request(.max(3))
    }
    
    func receive(completion: Subscribers.Completion<SubjectError>) {
        print("Received Error subscription")
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

struct Subjects_Part3 {
    
    func subjectImplementationExample1 () {
        
        let currentSubcriber = SubjectsStringSubscriber(combineIdentifier: CombineIdentifier())
        let subject = PassthroughSubject<String, SubjectError>()
        
        subject.subscribe(currentSubcriber)
        
        subject.send("A")
        subject.send("B")
        subject.send("C")
        
        let cancellableSubscriber = subject.sink { _ in
            print("")
        } receiveValue: { val in
            print("")
        }
        
        cancellableSubscriber.cancel()
    }
}
