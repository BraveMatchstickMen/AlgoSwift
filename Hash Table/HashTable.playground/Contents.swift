//: Hash Table

var hashTable = [String: String]()

hashTable["firstName"] = "Steve"
hashTable["hobbies"] = "Programming Swift"

"firstName".hashValue
"hobbies".hashValue

// Note: It is difficult to predict where in the array your objects end up. Hence, dictionaries do not guarantee any particular order of the elements in the hash table.
