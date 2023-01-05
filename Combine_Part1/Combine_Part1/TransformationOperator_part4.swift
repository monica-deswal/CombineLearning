//
//  TransformationOperator.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import Foundation
import Combine

struct TransformationOperator_part4 {
    
    func collectOperator() {
        let cancellablePub = ["A", "B", "C", "D"].publisher.collect().sink { _ in } receiveValue: { arrayOfstring in
            print("The value of the string \(arrayOfstring)")
        }
        
        let cancellablePub1 = ["A", "B", "C", "D"].publisher.collect(2).sink { _ in } receiveValue: { arrayOfstring in
            print("The value of the string \(arrayOfstring)")
        }
    }
    
    func mapOperator() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        let cancellablePublisher = [123,45,67].publisher.map { val in
            formatter.string(from: val)
        }.sink {
            print($0)
        }
    }
  
    func mapKeyPathOperator() {
        let publisher = PassthroughSubject<Point, Never>()
        
        publisher.map(\.x, \.y).sink { x, y in
            
            print("x is \(x) and y is \(y)")
        }
        
        publisher.send(Point(x: 2, y: 10))
        publisher.send(Point(x: 12, y: 14))
    }
    
    func flatMapOperator() {
        let citySchool = School(name: "Foundation Head School", noOfStudents: 100)
        let school = CurrentValueSubject<School, Never>(citySchool)
        
        // Having the issue with sink as it will consider it as the same value so only once get even we assign the value to current value subject. Internal publication is not getting called
        let cancellableSub = school.sink {
            print($0)
        }
        
        // not working
        //citySchool.noOfStudents.value += 1
        
        let townSchool = School(name: "Town Head School", noOfStudents: 45)
        school.value = townSchool
        
       
        let cancellable = school.flatMap {
            $0.noOfStudents
        }.sink {
            print($0)
        }
        
        citySchool.noOfStudents.value += 1
    }
    
    func replaceNil() {
    let cancellableSubscriber =  ["A", "B", nil, "C"].publisher.replaceNil(with: "*")
            .map { $0! }
            .sink {
                print($0)
            }
    }
    
    func replaceEmptyOperator() {
        let empty = Empty<Int, Never>()
        
        empty.sink {
            print($0)
        } receiveValue: {
            print($0)
        }

    }
    
    func scanOperator() {
        
        let publisher = (1...10).publisher
        
        publisher.scan([]) { numbers, value -> [Int] in
            numbers + [value]
        }.sink {
            print($0)
        }
    }
}


struct Point {
    let x: Int
    let y: Int
}

struct School {
    let name: String
    let noOfStudents: CurrentValueSubject<Int, Never>
    
    init(name: String, noOfStudents: Int) {
        self.name = name
        self.noOfStudents = CurrentValueSubject(noOfStudents)
    }
}
