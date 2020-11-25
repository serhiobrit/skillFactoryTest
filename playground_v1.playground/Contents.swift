import UIKit

print("---------------------------1-----------------------------")

// 1. Создайте перечисление для ошибок. Добавьте в него 3 кейса:
//ошибка 400,
//ошибка 404,
//ошибка 500.
//Далее создайте переменную, которая будет хранить в себе какую-либо ошибку (400 или 404 или 500). И при помощи do-catch сделайте обработку ошибок перечисления. Для каждой ошибки должно быть выведено сообщение в консоль.

enum GeneratedError: Error {
    case badRequest //400
    case notFound //404
    case iAmTeapot //418
    case internalServerError //500
}

var currentError = true

var badRequest = false
var notFound = false
var iAmTeapot = false
var internalServerError = false

print("---------------------------2-----------------------------")

//Теперь добавьте проверку переменных в генерирующую функцию и обрабатывайте её!

func errorResponse() throws {
    if badRequest {throw GeneratedError.badRequest}
    if notFound {throw GeneratedError.notFound}
    if iAmTeapot {throw GeneratedError.iAmTeapot}
    if internalServerError {throw GeneratedError.internalServerError}
}

iAmTeapot = currentError

do {
    try errorResponse()
}
catch GeneratedError.badRequest {
    print ("Bad Request")
}
catch GeneratedError.notFound {
    print ("Not Found")
}
catch GeneratedError.iAmTeapot {
    print ("I’m a teapot")
}
catch GeneratedError.internalServerError {
    print ("Internal Server Error")
}

print("---------------------------3-----------------------------")

//Напишите функцию, которая будет принимать на вход два разных типа и проверять: если типы входных значений одинаковые, то вывести сообщение “Yes”, в противном случае — “No”.

func compare <T, E> (a: T, b: E) {
    if type(of: a) == type(of: b) {
        print ("Equal types")
    } else {
        print ("different types")
    }
}

compare(a: 3, b: "text")

print("---------------------------4-----------------------------")

//Реализовано то же самое, что и в пункте 3, но если тип входных значений различается, выбрасывается исключение. Если тип одинаковый — исключение тоже выбрасывается.

enum CompareResult: Error {
    case equal
    case different
}

var equal = false
var different = false

func compare1 <T, E> (c: T, d: E) throws {
    if type(of: c) == type(of: d) {throw CompareResult.equal}
    if type(of: c) != type(of: d) {throw CompareResult.different}
}

do {
    try compare1(c: 3, d: "text")
}
catch CompareResult.equal {
    print ("Тип переменных одинаковый")
}
catch CompareResult.different {
    print ("Тип переменных различный")
}

print("---------------------------5-----------------------------")

//Есть функция, которая принимает на вход два любых значения и сравнивает их при помощи оператора равенства (==).

func compareEquality <T: Equatable>(value1: T, value2: T){
        if value1 == value2 {
            print("введенные значения равны")
        } else {
            print("введенные значения отличаются")
    }
}

compareEquality(value1: "text", value2: "teXt")
