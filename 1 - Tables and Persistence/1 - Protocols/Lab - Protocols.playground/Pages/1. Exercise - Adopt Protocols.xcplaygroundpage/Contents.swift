/*:
## Exercise - Adopt Protocols: CustomStringConvertible, Equatable, and Comparable
 
 Create a `Human` class with two properties: `name` of type `String`, and `age` of type `Int`. You'll need to create a memberwise initializer for the class. Initialize two `Human` instances.
 */
import Foundation
class Human: CustomStringConvertible, Equatable, Comparable, Codable {

    
    //for comparable
    static func < (lhs: Human, rhs: Human) -> Bool {
        return lhs.age < rhs.age
    }
    
    //for equatable
    static func == (lhs: Human, rhs: Human) -> Bool {
        if lhs.name == rhs.name && lhs.age == rhs.age {
            return true
        }
        return false
    }
    //for customStringConvertible
    var description: String {
        "Hi my name is \(name) and I am \(age) years old"
    }
    
    
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let human1 = Human(name: "Jestin", age: 23)
let human2 = Human(name: "Emma", age: 28)

//:  Make the `Human` class adopt the `CustomStringConvertible` protocol. Print both of your previously initialized `Human` objects.
print(human1)
print(human2)


//:  Make the `Human` class adopt the `Equatable` protocol. Two instances of `Human` should be considered equal if their names and ages are identical to one another. Print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are equal to eachother (using `==`). Then print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are not equal to eachother (using `!=`).
print(human1 == human2)
print(human1 != human2)

//:  Make the `Human` class adopt the `Comparable` protocol. Sorting should be based on age. Create another three instances of a `Human`, then create an array called `people` of type `[Human]` with all of the `Human` objects that you have initialized. Create a new array called `sortedPeople` of type `[Human]` that is the `people` array sorted by age.

let human3 = Human(name: "Jestin", age: 23)
let human4 = Human(name: "Tiana", age: 19)
let human5 = Human(name: "Caleb", age: 19)
var people: [Human] = [human1, human2, human3, human4, human5]
var sortedArray: [Human] = people.sorted()
print(sortedArray)
//:  Make the `Human` class adopt the `Codable` protocol. Create a `JSONEncoder` and use it to encode as data one of the `Human` objects you have initialized. Then use that `Data` object to initialize a `String` representing the data that is stored, and print it to the console.
let jsonEncoder = JSONEncoder()

if let jsonData = try? jsonEncoder.encode(human1),
//converting the data into a string in order to be able to read it
let jsonString = String(data: jsonData, encoding: .utf8)
{
    print(jsonString)
}

/*:
page 1 of 5  |  [Next: App Exercise - Printable Workouts](@next)
 */
