import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
    print("Performing work item!")
}

//workItem.perform()

let queue = DispatchQueue(label: "my queu barrier", qos: .utility, attributes: .concurrent)
queue.asyncAfter(deadline: .now() + 1, execute: workItem)

workItem.notify(queue: .main) {
    print("workintem is complete")
}
workItem.isCancelled
workItem.cancel()

workItem.wait()


