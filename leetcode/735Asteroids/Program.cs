using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Asteroids_735
{
    class Solution
    {
        static void Main(string[] args)
        {
            int[] r1 = AsteroidCollision(new int[] { 10, 2, -5});  // [10]
            int[] r2 = AsteroidCollision(new int[] { 5, 10, -5 }); // [5, 10]
            int[] r3 = AsteroidCollision(new int[] { 8, -8 }); // []
            int[] r4 = AsteroidCollision(new int[] { -2, -2, -2, -2 }); // [-2, -2, -2, -2]
            int[] r5 = AsteroidCollision(new int[] { -2, -1, 1, 2}); // no collisions
        }

        public static int[] AsteroidCollision(int[] asteroids)
        {
            List<int> survivors = new List<int>();

            int a = 0;

            while (a < asteroids.Length) 
            {
                if (survivors.Count == 0)
                {
                    survivors.Add(asteroids[a]);
                    ++a;
                    continue;
                }

                int first = survivors.Last<int>();
                int second = asteroids[a];

                if (SignsWillLeadToCollision(first, second))
                {
                    if (Math.Abs(first) > Math.Abs(second))
                    {
                        // second is destroyed. First remains in the survivor list
                        ++a; // move on to the next asteroid
                    }
                    else if (Math.Abs(second) > Math.Abs(first))
                    {
                        // first is destroyed
                        survivors.RemoveAt(survivors.Count - 1);

                        // evaluate second again with the new end of survivors
                        continue;
                    }
                    else
                    {
                        // both are destroyed
                        survivors.RemoveAt(survivors.Count - 1);
                        ++a;
                        continue; 
                    }
                }
                else
                {
                    // signs are the same, so they will not collide
                    survivors.Add(second);
                    ++a;  // move on to the next asteroid
                }
            }

            int[] result = survivors.OfType<int>().ToArray();

            // invariant: 
            //  - signs are all the same or 
            //  - no survivors or 
            //  - 
            return result;
        }


        private static bool SignsWillLeadToCollision(int first, int second)
        {
            // positive is traveling to right, negative to left.

            if (first < 0 && second < 0)
            {
                // both travel left, no collision
            } 
            else if (first < 0 && second > 0)
            {
                // first left, second right, no collision
            }
            else if (first > 0 && second < 0)
            {
                // first right, second left => collision
                return true;
            }
            else if (first > 0 && second > 0)
            {
            }

            return false;
        }
    }
}

          