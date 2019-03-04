//: Recursion
// f(n) = f(n - 1) + 1, f(1) = 1

// Stack overflow
var depth = 0

// Repetitive computation
var hasSovledMap = [Int: Int]()

func f(_ n: Int) -> Int {
    if n == 1 { return 1 }
    if n == 2 { return 2 }
    if let hasSovledNum = hasSovledMap[n] {
        return hasSovledNum
    }
    let ret = f(n - 1) + f(n - 2)
    hasSovledMap[n] = ret
    return ret
}

f(5)
f(3)
