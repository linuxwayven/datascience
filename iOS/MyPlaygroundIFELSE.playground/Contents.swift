//: Playground - noun: a place where people can play

import UIKit

func loveCalculator (yourName:String, theirName:String) -> String {
    let loveScore = arc4random_uniform(101)
    let pepe = 120
    print(pepe)
    
    if loveScore > 80 {
        return "Love Score: \(loveScore) You love each other like Kenya West"
    }
    else if (loveScore > 40 && loveScore <= 80) {
        return "Love Score: \(loveScore)  medium score"
    }
    else {
        return "Love Score: \(loveScore) No love is posible"
    }
}

print (loveCalculator (yourName:"Jesus Ruiz", theirName: "Ingrid Colina"))

print(32)


