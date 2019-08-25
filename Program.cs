using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Collections;
using System.ComponentModel;
using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.Serialization;
using System.Text.RegularExpressions;
using System.Text;
using System;
using System.Diagnostics.Contracts;

// https://www.hackerrank.com/challenges/compare-the-triplets/problem


class Solution {

    // Complete the compareTriplets function below.
    static List<int> compareTriplets(List<int> a, List<int> b) {

        // Validate inputs
        Contract.Assert(a.Count == 3);
        Contract.Assert(b.Count == 3);

        // Create place for the results.
        // Alice's score is result[0]
        // Bob's score is result[1]
        // In a language with pointers, I'd alias each element with a friendly name.

        List<int> result = new List<int>(2) {0, 0};

        // Implementation.
        // A couple of choices: 
        // - an iterator that walks through a[i] looking at b[i] -- supplying a lamba appied at each a[i] that is the comparator
        // - a simple for loop 

        for (int i = 0; i < a.Count; ++i) 
        {
            DoCompare(a[i], b[i], result);
        } 

        Contract.Assert(result.Count == 2);
        return result;
    }


    static void DoCompare(int a, int b, List<int> score)
    {
            if (a > b)
            {
                // Alice wins
                ++score[0];
            } else if (a < b)
            {
                // Bob wins
                ++score[1];
            }
            // else no one wins
    }


    static void Main(string[] args) {
        // TextWriter textWriter = new StreamWriter(@System.Environment.GetEnvironmentVariable("OUTPUT_PATH"), true);
        TextWriter textWriter = new StreamWriter("./output.txt", true);

        List<int> a = Console.ReadLine().TrimEnd().Split(' ').ToList().Select(aTemp => Convert.ToInt32(aTemp)).ToList();

        List<int> b = Console.ReadLine().TrimEnd().Split(' ').ToList().Select(bTemp => Convert.ToInt32(bTemp)).ToList();

        List<int> result = compareTriplets(a, b);

        textWriter.WriteLine(String.Join(" ", result));

        textWriter.Flush();
        textWriter.Close();
    }
}
