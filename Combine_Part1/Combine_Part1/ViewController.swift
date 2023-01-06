//
//  ViewController.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    @IBAction func Part2(_ sender: Any) {
        publisherSubscriptionExamplePart2Implementation()
    }
    @IBAction func Part3(_ sender: Any) {
        subjectsPart3Implementation()
    }
    @IBAction func Part4(_ sender: Any) {
        transformationOperatorPart4Implementation()
    }
    @IBAction func Part5(_ sender: Any) {
        filteringOperatorPart5Implementation()
    }
    @IBAction func Part6(_ sender: Any) {
        challengeTheLearningsImplementation()
    }
    @IBAction func Part7(_ sender: Any) {
    }
    
    @IBAction func challengeTheLearningsImplementation(_ sender: Any) {
        challengeTheLearningsImplementation()
    }
}

//MARK: PublisherSubscriptionExamplePart2
extension ViewController {
    func publisherSubscriptionExamplePart2Implementation() {
        let obj = PublisherSubscriptionExamplePart2()
        obj.subscriberExample1()
    }
}

//MARK: PublisherSubscriptionExamplePart2
extension ViewController {
    func subjectsPart3Implementation() {
        let obj = SubjectsPart3()
        
        obj.subjectImplementationExample1()
        
        obj.subjectImplementationExample2()
    }
}

//MARK: TransformationOperatorPart4
extension ViewController {
    func transformationOperatorPart4Implementation() {
        let obj = TransformationOperatorPart4()
        
        obj.collectOperator()
        
        obj.mapOperator()
        
        obj.mapKeyPathOperator()
        
        obj.flatMapOperator()
        
        obj.replaceNil()
        
        obj.replaceEmptyOperator()
        
        obj.scanOperator()
    }
}

//MARK: FilteringOperatorPart5
extension ViewController {
    func filteringOperatorPart5Implementation() {
        let obj = FilteringOperatorPart5()
        
        obj.filterOperator()
        
        obj.removeDuplicates()
        
        obj.compactMap()
        
        obj.ignoreOutputOperator()
        
        obj.firstOperator()
        
        obj.lastOperator()
        
        obj.dropFirstOperator()
        
        obj.dropWhileOperator()
        
        obj.dropUntillOutputFromOperator()
        
        obj.prefixOperator()
    }
}

//MARK: ChallengeTheLearnings
extension ViewController {
    func challengeTheLearningsImplementation() {
        let obj = ChallengeTheLearnings()
        
        obj.performTheChallenge()
        
    }
}
