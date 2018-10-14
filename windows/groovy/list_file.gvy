// Reads each line from /tmp/sample.txt
// and string them together separated by '|'
//
def str = []
def number = 0
new File('/tmp/sample.txt').eachLine { 
str += it.tokenize("|")
}
return str
