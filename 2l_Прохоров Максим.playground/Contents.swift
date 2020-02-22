import Cocoa


//1. Написать функцию, которая определяет, четное число или нет.

func num_check2(_ x: Int) -> String {
    if x == 0 {
        return "Ноль делить нельзя"
    }else if ((x % 2) == 0) {
        return "Четное (Делится без остатка)"
    }else {
        return "Нечетное (Делится с остатком)"
    }
}
num_check2(9)

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func num_check3(_ x: Int) -> String {
    if x == 0 {
        return "Ноль делить нельзя"
    }else if ((x % 3) == 0) {
        return "Делится без остатка"
    }else {
        return "Делится с остатком"
    }
}
num_check3(5)

//3. Создать возрастающий массив из 100 чисел.

var array: [Int] = []
for i in 0...99 {
    array.append(i)
}
array.count
array

var array2 = Array(repeating: 0, count: 100)
for (index, _) in array2.enumerated() {
    array2[index] += (index + 1)
}
array2.count
array2

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

var i = array.count - 1

repeat {
    if array[i] != 0 {
        ((array[i] % 2) == 0) ? array.remove(at:(i)) : nil
        !((array[i] % 3) == 0) ? array.remove(at:(i)) : nil
    }
    i-=1
} while i >= 0
array


//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.

var fib_array: Array<Decimal> = [0]

func newFib(temp_array: Array<Decimal>) -> Decimal {
    if temp_array.count == 0 {
        return 1
    } else {
        return (temp_array[temp_array.count-1] < 1) && (temp_array.count < 2 ) ? 1 : temp_array[temp_array.count-1]+temp_array[temp_array.count-2]
    }
}

repeat {
    fib_array.append(newFib(temp_array: fib_array))
}while fib_array.count < 100

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.

var whole_number: Array<Int> = [2]
var whole_number_max: Int = 100
var simple_number: Array<Int> = []
repeat {
    whole_number.append(whole_number.last! + 1)
}while whole_number.count < whole_number_max
whole_number.count
whole_number
repeat {
    simple_number.append(whole_number.first!)
    whole_number.dropFirst()
    if whole_number.count != 0 {
        var ind = whole_number.count
        repeat {
            ind -= 1
            if (whole_number[ind] % simple_number.last!) == 0 { whole_number.remove(at:(ind)) }
        }while ind > 0
    }
}while whole_number.count > 0
simple_number

