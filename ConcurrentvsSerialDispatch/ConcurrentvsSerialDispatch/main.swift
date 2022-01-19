//
//  main.swift
//  ConcurrentvsSerialDispatch
//
//  Created by Subhankar Acharya on 18/01/22.
//

import Foundation


//let serialQueue = DispatchQueue(label: "subhankar.serial.queue")
//
//serialQueue.async {
//    print("Task 1 started")
//    // Do some work..
//    print("Task 1 finished")
//}
//serialQueue.async {
//    print("Task 2 started")
//    // Do some work..
//    print("Task 2 finished")
//}

//let concurrentQueue = DispatchQueue(label: "subhankar.concurrent.queue", attributes: .concurrent)
//
//concurrentQueue.async {
//    print("Task 1 started")
//    // Do some work..
//    print("Task 1 finished")
//}
//concurrentQueue.async {
//    print("Task 2 started")
//    // Do some work..
//    print("Task 2 finished")
//}

final class Messenger {

    private var messages: [String] = []

    private var queue = DispatchQueue(label: "messages.queue", attributes: .concurrent)

    var lastMessage: String? {
        return queue.sync {
            messages.last
        }
    }

    func postMessage(_ newMessage: String) {
        queue.async(flags: .barrier) {
            self.messages.append(newMessage)
        }
    }
}

let messenger = Messenger()
// Executed on Thread #1
messenger.postMessage("Hello Subhankar!")
messenger.postMessage("Hello Shiwali!")
// Executed on Thread #2
print(messenger.lastMessage as Any) // Prints: Hello Subhankar!
