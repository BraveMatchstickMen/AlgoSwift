//: A more efficient queue

public struct Queue<T> {
    private var array = [T?]()
    private var head = 0

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count - head
    }

    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else {
            return nil
        }

        array[head] = nil
        head += 1

        let percentage = Double(head) / Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }

        return element
    }

    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

var q = Queue<String>()
q.enqueue("Ada")
q.enqueue("Steve")
q.enqueue("Tim")
q

q.dequeue()
q.dequeue()

q.enqueue("Grace")
