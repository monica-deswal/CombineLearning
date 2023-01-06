//
//  TransformationOperator.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import Foundation
import Combine


struct TransformationOperatorPart4 {
    
    //MARK: Collect is powerful operator that allows us to receive all items at once from a publisher. It collects all received elements and emit a single array of the collection when the upstream publisher finishes.
    //Pair
    func collectOperator() {
        let _ = ["A", "B", "C", "D"].publisher.collect().sink { _ in } receiveValue: { arrayOfstring in
            print("The value of the string \(arrayOfstring)")
        }
        
        let _ = ["A", "B", "C", "D"].publisher.collect(2).sink { _ in } receiveValue: { arrayOfstring in
            print("The value of the string \(arrayOfstring)")
        }
    }
    
    
    //MARK: As the name suggests, this operator maps or transforms the elements a publisher emits
    func mapOperator() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        let _ = [123,45,67].publisher.map { val in
            formatter.string(from: val)
        }.sink {
            print($0 ?? "")
        }
    }
    
    func mapKeyPathOperator() {
        let publisher = PassthroughSubject<Point, Never>()
        
        publisher.send(Point(x: 2, y: 10))
        publisher.send(Point(x: 12, y: 14))
        
        let _ = publisher.map(\.x, \.y).sink { x, y in
            
            print("x is \(x) and y is \(y)")
        }
    }
    
    // As we are having the issue, we are having the publisher which is CurrentValueSubject and if try to update the value of the object "School" then this publisher is not awaken as the value inside is getting updated.
    //MARK: FlatMap is used to flatten the nested publishers.
    //MARK: CompactMap leads to the omission of nil from the published values.
    func flatMapOperator() {
        let citySchool = School(name: "Foundation Head School", noOfStudents: 100)
        let school = CurrentValueSubject<School, Never>(citySchool)
        
        // Having the issue with sink as it will consider it as the same value so only once get even we assign the value to current value subject. Internal publication is not getting called
        let _ = school.sink {
            print($0)
        }
        
        // not working
        //citySchool.noOfStudents.value += 1
        
        let townSchool = School(name: "Town Head School", noOfStudents: 45)
        school.value = townSchool
        
        
        let _ = school.flatMap {
            $0.noOfStudents
        }.sink {
            print($0)
        }
        
        citySchool.noOfStudents.value += 1
    }
    
    //MARK: Replace nil items with the value we specify.
    func replaceNil() {
        let _ =  ["A", "B", nil, "C"].publisher.replaceNil(with: "*")
            .map { $0! }
            .sink {
                print($0)
            }
    }
    
    //MARK: A publisher that replaces an empty stream with a provided element.
    // Can we used for sending the blank success of the Api response
    func replaceEmptyOperator() {
        let empty = Empty<Int, Never>()
        
        _ =  empty.sink {
            print($0)
        } receiveValue: {
            print($0)
        }
        
    }
    
    //MARK: Transforms elements from the upstream publisher by providing the current element to a closure along with the last value returned by the closure
    func scanOperator() {
        
        let publisher = (1...10).publisher
        let _ =   publisher.scan([]) { numbers, value -> [Int] in
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
