
import Foundation

func performRecursionSection()
{
    basicRecursion(max:5, current:1);
    print("Fibonacci example: \(fibonacci(n:10))");
    printFibonacciSequence(toMax: 10);
    print(factorial(n:10));
}

func basicRecursion(max:Int, current:Int)
{
    if (current > max) {
        return;
    }
    print(current);
    basicRecursion(max:max, current:current + 1);
}

func fibonacci(n:Int) -> Int
{
    if (n <= 2) {
        return 1;
    } else {
        return fibonacci(n:n - 1) + fibonacci(n:n - 2);
    }
}

func printFibonacciSequence(toMax:Int)
{
    for i in 1...toMax {
        print("\(i) : \(fibonacci(n:i))");
    }
}

func factorial(n:Int) -> Int
{
    if (n <= 0) {
        return 1;
    }
    return n * factorial(n:n - 1);
}

