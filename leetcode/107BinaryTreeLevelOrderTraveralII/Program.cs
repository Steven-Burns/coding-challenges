using System;
using System.Collections.Generic;

namespace _107BinaryTreeLevelOrderTraveralII
{
    using MyTuple = System.Tuple<TreeNode, int>;


    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }

    // Definition for a binary tree node.
    public class TreeNode {
        public int val;
        public TreeNode left;
        public TreeNode right;
        public TreeNode(int val=0, TreeNode left=null, TreeNode right=null) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }




public class Solution 
{
    public IList<IList<int>> 
    LevelOrderBottom(TreeNode root) 
    {

/* This is less messy thatn Tuple<T>, but requires C# 7
//explicit Item typing
(string Message, int SomeNumber) t = ("Hello", 4);
//or using implicit typing 
var t = (Message:"Hello", SomeNumber:4);
*/

        if (null == root) 
        {
            return new List<IList<int>>();
        }

        Stack<IList<int>> s = new Stack<IList<int>>();
        List<MyTuple> q = new List<MyTuple>();

        IList<int> currentLevelList = new List<int>();
        int currentLevel = 0;
        int qIndex = 0;

        q.Add(new MyTuple(root, currentLevel));
        while (qIndex < q.Count) 
        {
            // C# docs say that List<T> indexing is O(1). 
            MyTuple t = q[qIndex];
            int newLevel = t.Item2 + 1;

            if (null != t.Item1.left) 
            {
                q.Add(new MyTuple(t.Item1.left, newLevel));
            }
            if (null != t.Item1.right)
            {
                q.Add(new MyTuple(t.Item1.right, newLevel));                  
            }
            if (t.Item2 != currentLevel)
            {
                // level we're working on has changed, so we're done forming 
                // the currentLevelList.
                s.Push(currentLevelList);
                currentLevelList = new List<int>();
            }
            currentLevelList.Add(t.Item1.val);
            currentLevel = t.Item2;

            ++qIndex;
        }
        s.Push(currentLevelList);
     
        // Conversion to some container type that implements IList would not be necessary
        // if the challenge interface's desired result type was IEnumerable<IEnumerable<T>>.
        // ToArray() is super slow.
        return s.ToArray();
    }

}

}