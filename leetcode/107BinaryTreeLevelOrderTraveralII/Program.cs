using System;
using System.Collections.Generic;
using MyTuple = System.Tuple<TreeNode, int>;


namespace _107BinaryTreeLevelOrderTraveralII
{
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public int val;
 *     public TreeNode left;
 *     public TreeNode right;
 *     public TreeNode(int val=0, TreeNode left=null, TreeNode right=null) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */


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

        List<MyTuple> q = new List<MyTuple>();
        q.Add(new MyTuple(root, 0));
        int index = 0;
        int maxLevels = 0;
        while (index < q.Count) 
        {
            // C# docs say that List<T> indexing is O(1). 
            MyTuple t = q[index];
            if (null != t.Item1.left) 
            {
                int newLevel = t.Item2 + 1;
                q.Add(new MyTuple(t.Item1.left, newLevel));
                maxLevels = Math.Max(maxLevels, newLevel);
            }
            if (null != t.Item1.right)
            {
                int newLevel = t.Item2 + 1;
                q.Add(new MyTuple(t.Item1.right, newLevel));                  
                maxLevels = Math.Max(maxLevels, newLevel);
            }
            ++index;
        }

        // At this point, q, is a list of tuples where the first item is a TreeNode
        // and the second item is the level of that node in the tree.

        // Compose sub-lists consisting of just the values from the same level.
        index = 0;
        IList<IList<int>> result = new IList<int>[maxLevels + 1];
        IList<int> currentLevelList = new List<int>();
        int currentLevel = 0;
        while (index < q.Count) 
        {
            MyTuple t = q[index];
            if (t.Item2 != currentLevel)
            {
                // we're done forming the currentLevelList
                result[maxLevels - currentLevel] = currentLevelList;
                currentLevelList = new List<int>();
            }
            currentLevelList.Add(t.Item1.val);
            currentLevel = t.Item2;
            ++index;
        }
        result[0] = currentLevelList;
        
        return result;
    }



    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
}