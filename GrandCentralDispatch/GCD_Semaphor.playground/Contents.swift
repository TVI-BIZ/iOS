import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
let queue = DispatchQueue(label: "my queue", attributes: .concurrent)
let semaphore = DispatchSemaphore(value: 2)

queue.async{
    semaphore.wait(timeout: .distantFuture)
    Thread.sleep(forTimeInterval: 4)
    print("Block 1")
    semaphore.signal()
}
queue.async{
    semaphore.wait(timeout: .distantFuture)
    Thread.sleep(forTimeInterval: 2)
    print("Block 2")
    semaphore.signal()
}
queue.async{
    semaphore.wait(timeout: .distantFuture)
    print("Block 3")
    semaphore.signal()
}
queue.async{
    semaphore.wait(timeout: .distantFuture)
    print("Block 4")
    semaphore.signal()
}


