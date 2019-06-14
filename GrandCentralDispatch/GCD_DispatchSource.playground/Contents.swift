import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
let queue = DispatchQueue(label: "MyQeue", attributes: .concurrent)

let timer = DispatchSource.makeTimerSource(queue: queue)

timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: DispatchTimeInterval.microseconds(300))
timer.setEventHandler {
    print("Hello World!")
}
timer.setCancelHandler {
    print("Timer is canceled!")
}
timer.resume()



