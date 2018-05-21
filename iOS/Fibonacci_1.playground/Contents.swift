//: Playground - noun: a place where people can play

import UIKit

/*
 Serie de Fibonacci
 
 0,1,1,2,3,5,8
 
 */

func fibonacci(until: Int) -> Void{
    
    var A = [Int]()
    
    A.append(0)
    A.append(1)
    
    if ((until - 1) <= 0){
        print(A)
    }
    else {
        for iteracion in 2 ... until {
            A.append(A[iteracion - 2] + A[iteracion - 1])
        }
        
        print(A)
    }
    
}



fibonacci(until: 6)
