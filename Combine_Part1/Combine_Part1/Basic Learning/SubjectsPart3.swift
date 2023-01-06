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

//MARK: A subject is publisher that you can use to "inject" values into stream, by calling it's send(:) methid.

//MARK: A Passthrough subject boradcasts element to doenstream subcribers and provides a convenient way to adapt existing imperative code to Combine, This type of subject only passes through values meaning that it does not capture any state and will drop values if there aren't any subscribers set.
// A passthroughSubject is initialized without any value.



struct SubjectsPart3 {
    
    func subjectImplementationExample1 () {
        
        let currentSubcriber = SubjectsStringSubscriber(combineIdentifier: CombineIdentifier())
        let subject = PassthroughSubject<String, SubjectError>()
        
        subject.subscribe(currentSubcriber)
        
        subject.send("A")
        subject.send("B")
        subject.send("C")
        
        let cancellableSubscriber = subject.sink { _ in
            print("")
        } receiveValue: {
            print($0)
        }
        
        cancellableSubscriber.cancel()
    }
    
    func subjectImplementationExample2 () {
        
        
        let uploader = Uploader()
        
        uploader.startUpload()

        let cancellableSubscriber =   uploader.subject.sink { completion in
            switch completion {
            case .finished:
                print("Received finished")
            case .failure(let error):
                print("Received error: \(error)")
            }
        } receiveValue: { message in
            print("Received message: \(message)")
        }
        
        do {
            sleep(5)
            uploader.finishedUpload()
        }
        
    }
}

//MARK: A CurrentValueSubject wraps a single value and publish a new element whenever the value changes. A new element is published even if the updated value equals the current values. Unlike the passthroughSubject, a currentvaluesubject always holds a value.

    
    struct Uploader {
        
        enum State {
            case pending, uploading, finished
        }
        
        enum Error: Swift.Error {
            case uploadFailed
        }
        
        let subject = CurrentValueSubject<State, Error>(.pending)
        
        
        func startUpload() {
            subject.send(.uploading)
        }
        
        
        func finishedUpload() {
            subject.value = .finished
            subject.send(completion: .finished)
        }
        
        func failUpload() {
            subject.send(completion: .failure(.uploadFailed))
        }
    }


//MARK: A passthroughSubject is like a doorbell push button. When someone rings the bell, you're only nitified when you're at home.
//MARK: A currentValueSubkect is like a light switch. When a light is turned on while you're away, you'll notice it was turned on when you get back home.
