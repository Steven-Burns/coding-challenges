using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypoFinder
{
    static class Program
    {
        static void writeDebug(string line)
        {
            Console.WriteLine("DBG: " + line);
        }

        static Dictionary<char, char[]> nearCharactersMap = new Dictionary<char, char[]>();


        static void initNearCharactersMap()
        {
            nearCharactersMap.Add('g', new char[] { 'g', 'h', 'i' });
            nearCharactersMap.Add('o', new char[] { 'o', 'i', 'l' });
        }

        static char[] get_nearby_chars(char c)
        {
            char[] result = nearCharactersMap[c];
            return result;   
        }


        static bool is_word(string candidate)
        {
            return true;
        }


        static IEnumerable<string> findPermutations(string word)
        {
            if (String.IsNullOrEmpty(word))
            {
                return null;
            }

            char[] nearChars = get_nearby_chars(word[0]);
            IEnumerable<string> tailPermutations = findPermutations(word.Substring(1, word.Length - 1));
            var result = new List<string>();

            if (tailPermutations == null)
            {
                foreach (char c in nearChars)
                {
                    result.Add(new string(c, 1));
                }
            } 
            else {
                foreach (char c in nearChars)
                {
                    foreach (string s in tailPermutations)
                    {
                        string r = new string (c, 1) + s;
                        writeDebug("adding " + r);
                        result.Add(r);
                    }
                }
            }
            return result;                
        }

        static void Main(string[] args)
        {
            initNearCharactersMap();
            writeDebug("starting...");
            IEnumerable<string> p = findPermutations("goo");
            writeDebug("results:");
            foreach (string s in p)
            {
                writeDebug(s);
            }
            Console.ReadLine();
        }
    }
}
