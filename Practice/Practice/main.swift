//
//  main.swift
//  Practice
//
//  Created by Subhankar Acharya on 11/02/22.
//

import Foundation


/*
 
 Prateek recently started eating chocolates. The shopkeeper tells Prateek that for every three chocolates Prateek eats, he will give him one chocolate in exchange for three chocolate wrappers. Now, Prateek is confused about how many chocolates he can eat.
 Given the total money Prateek has and the cost of one chocolate, help him figure out how many chocolates he can eat.

 */

var wineDict:[String: Double] = [ "name": "Wine A", price: 8.99 , "name": "Wine 32", price: 13.99 , "name": "Wine 9", price: 10.99 ]



func choosenWine(temPDict: [String:Double]) -> String {
    
    guard let = temPDict else { return "tempDict in nil"}
    var sortedDictionary = wineDict.sorted(by: $0.1 < $1.1)
    
    return wineName
}

/*protocol classAdelegate {
    func fly()
}

class A {
    weak var delegate: classAdelegate
    
}


class B: classAdelegate {
    let a = A()
    
    a.delegate = self
}
/*
