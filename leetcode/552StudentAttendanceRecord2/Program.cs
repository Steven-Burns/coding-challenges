using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _552StudentAttendanceRecord2
{
    class Solution
    {
        static void Main(string[] args)
        {
            string elements = "ALP";
            foreach (string r in Permute(elements, 2))
            {
                Console.WriteLine(r);
            }
            Console.ReadLine();
        }

        public int CheckRecord(int n)
        {
            return 0;
        }

        public static List<string> Permute(string elements, int length)
        {
            List<string> result = new List<string>();
            if (length == 1)
            {
                foreach (char c in elements)
                {
                    result.Add(c.ToString());
                }
            } 
            else if (length > 1)
            {
                foreach (char c in elements)
                {
                    foreach (string p in Permute(elements, length - 1))
                    {
                        result.Add(c + p);
                    }
                }
            }
            return result;
        }
    }
}
