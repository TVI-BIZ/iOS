import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
let queue = DispatchQueue(label: "ru.swiftbook",  attributes: .concurrent)
let group = DispatchGroup()

queue.async(group: group){
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}
queue.async(group: group){
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}

group.notify(queue: .main) {
    print("All done in group: group")
}
let secondGroup = DispatchGroup()
secondGroup.enter()
queue.async(group: group){
    for i in 0...30 {
        if i == 30 {
            print(i)
            secondGroup.leave()
        }
    }
}

let result = secondGroup.wait(timeout: .now() + 3)
print(result)

secondGroup.notify(queue: .main){
    print("All done in second group")
}
print("This print above last print")

secondGroup.wait()

