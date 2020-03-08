import UIKit

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.


let printSum: (Double) -> Void = { (washPrice: Double) -> Void in
    print("Стоимость мойки: " + String(format:"%.2f", washPrice))
}


protocol CarWashing: CustomStringConvertible {
    var washingSum: Double { get set }
}

class Sedan: CarWashing {
    var description: String = "Стоимость мойки: "
    var washingSum: Double
    var washingPrice: Double = 0
    
    init(washingPrice: Double) {
        self.washingPrice = washingPrice
        self.washingSum = washingPrice
        self.description = String(format:"%.2f", washingSum)
    }
}

class Trunk: CarWashing {
    var description: String = "Стоимость мойки: "
    var washingSum: Double
    var washingPrice: Double = 0
    var trailerkWashingPrice: Double = 0
    
    init(washingPrice: Double, trailerkWashingPrice: Double) {
        self.washingPrice = washingPrice
        self.trailerkWashingPrice = trailerkWashingPrice
        self.washingSum = washingPrice + trailerkWashingPrice
        self.description = String(format:"%.2f", washingSum)
    }
}

class Jeep: CarWashing {
    var description: String = "Стоимость мойки: "
    var washingSum: Double
    var washingPrice: Double = 0
    var veryDirtyK: Double = 1.2
    var veryDirty: Bool = false
    
    
    init(washingPrice: Double, veryDirty: Bool) {
        self.washingPrice = washingPrice
        self.veryDirty = veryDirty
        if (veryDirty) {
            self.washingSum = washingPrice * veryDirtyK
            self.description += String(format:"%.2f", washingSum)
        }else{
            self.washingSum = washingPrice
            self.description += String(format:"%.2f", washingSum)
        }
    }
}

struct Queue<T: CarWashing> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    mutating func pop() -> T? {
        //if elements.isEmpty { return nil } else { return elements.removeFirst() }
        if let element = elements.first {
            printSum(element.washingSum)
            return elements.removeFirst()
        } else { return nil }
    }
    var estimatedProfit : Double {
        var washingSum = 0.0
        for element in elements {
            washingSum += element.washingSum
        }
        return washingSum
    }
    
    subscript(elements: Int ...) -> Double? {
        var washingSum = 0.0
        let queueCount: Int = self.elements.count - 1
        for (_, val) in elements.enumerated() {
            if (val > queueCount) { return nil }
        }
        for index in elements where index < self.elements.count {
            washingSum += self.elements[index].washingSum
        }
        return washingSum
    }
}


var queueJeep = Queue<Jeep>()
var queueSedan = Queue<Sedan>()
var queueTrunk = Queue<Trunk>()

queueSedan.push(Sedan(washingPrice: 400))
queueSedan.push(Sedan(washingPrice: 400))
queueJeep.push(Jeep(washingPrice: 10, veryDirty: false))
queueJeep.push(Jeep(washingPrice: 200, veryDirty: false))
queueJeep.push(Jeep(washingPrice: 900, veryDirty: true))
queueJeep.push(Jeep(washingPrice: 700, veryDirty: false))
queueJeep.push(Jeep(washingPrice: 3000, veryDirty: false))
queueTrunk.push(Trunk(washingPrice: 1500, trailerkWashingPrice: 3700))
queueTrunk.push(Trunk(washingPrice: 1500, trailerkWashingPrice: 6000))

queueSedan.estimatedProfit
queueJeep.estimatedProfit
queueTrunk.estimatedProfit

queueJeep[0,1,4] //subscript, return sum
queueJeep[0,1,4,10] //subscript, return nil - out of range

queueJeep.pop()
queueJeep.pop()
queueJeep.pop()
queueJeep.pop()
queueJeep.pop()
queueJeep.pop()
queueJeep.pop()
queueJeep.pop()
