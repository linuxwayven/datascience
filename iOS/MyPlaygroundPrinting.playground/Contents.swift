

//func getMilk (howManyMilkCartons : Int) {
//        print ("go to shops")
//        print ("buy \(howManyMilkCartons) cartons of milk")
//
//        let priceToPay = howManyMilkCartons * 2
//
//        print ("pay \(priceToPay) $")
//        print ("come home")
//}

func getMilk (howManyMilkCartons : Int, howManyMuchMoneyRobotWasGiven : Int) -> Int {
    print ("go to shops")
    print ("buy \(howManyMilkCartons) cartons of milk")
    
    let priceToPay = howManyMilkCartons * 2
    
    print ("pay \(priceToPay) $")
    print ("come home")
    
    let change = howManyMuchMoneyRobotWasGiven - priceToPay
    
    return change
}

var amountOfChange = getMilk(howManyMilkCartons: 1, howManyMuchMoneyRobotWasGiven: 10)
print ("Hello master, here's you $\(amountOfChange) change")

