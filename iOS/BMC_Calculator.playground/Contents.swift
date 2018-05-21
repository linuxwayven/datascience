import UIKit

func calcBMI (weight : Double, height : Double) -> String {
    
    let bmi = weight / pow(height,2)
    var interpretation = ""
    
    if bmi > 25 {
        interpretation = "You are over weight"
    }
    else if (bmi > 18.5 && bmi < 25) {
        interpretation = "You have a normal weight"
    }
    else if bmi < 18.5 {
        interpretation = "You are underweight"
    }
    
    return "Your bmi is " + String(bmi) + " and " + interpretation
}

print (calcBMI(weight: 63, height: 1.8))

print (63)

