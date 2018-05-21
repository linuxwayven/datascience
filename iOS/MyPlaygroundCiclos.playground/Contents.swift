//: Playground - noun: a place where people can play

import UIKit

func beerSong(howManyBootles times: Int) -> String {
    var lyrics : String = ""
    
    for number in (2...times).reversed() {
        let newLine : String = "\n \(number) bottles of beer on the wall, \(number) bottles of beer \n Take one down and pass it around, \(number - 1) bottles of beer on the wall. \n"
        
        
        lyrics += newLine
    }
    
    lyrics += "\n 1 bottle of beer on the wall, 1 bottle of beer. \n Take one down and pass it around, no more bottles of beer on the wall. \n\n No more bottles of beer on the wall, no more bottles of beer. \n Go to the store and buy some more, 99 bottles of beer on the wall."
    
    return lyrics
}

print (beerSong(howManyBootles: 99))
