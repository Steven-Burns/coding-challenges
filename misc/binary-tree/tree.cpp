#include <string>
#include <cassert>
#include <stack>

using namespace std;



struct Node
{
   char data;

   // the unions avoid messy casting.
   union
   {
      Node* leftPtr;
      int   leftIndex;
   };
   union
   {
      Node* rightPtr;
      int   rightIndex;
   };
};



// used in Tree::RecursiveCopyAsBlock2, which is the smaller block
// representation.

struct Node1
{
   char data;
   bool hasLeft;
   bool hasRight;
};



// block - array to store the node
//
// last - last unused location in the block
//
// tree - the node at the root of the tree
//
// returns the index of the node stored, last will be the index of the
// last unused node 

int 
store_tree(Node block[], int& last, Node* tree)
{
   assert(block);
   assert(last >= 0);
   assert(tree);

   // this is a preorder traversal:

   int index = last;
   last++;

   // store the left subtree
   if (tree->leftPtr)
   {
      // last will come back modified 
      block[index].leftIndex = store_tree(block, last, tree->leftPtr);
   }

   // store the right subtree
   if (tree->rightPtr)
   {
      // last will come back modified 
      block[index].rightIndex = store_tree(block, last, tree->rightPtr);
   }

   // store the current node
   block[index].data = tree->data;

   return index;
}



// This variation "pre-allocates" an index for the node before making
// the recursive calls.

void 
store_tree2(Node block[], int& last, Node* tree)
{
   assert(block);
   assert(last >= 0);
   assert(tree);

   int index = last;

   // store the current node
   block[index].data = tree->data;

   // store the left subtree
   if (tree->leftPtr)
   {
      last++;
      block[index].leftIndex = last;
      store_tree2(block, last, tree->leftPtr);
   }

   // store the right subtree
   if (tree->rightPtr)
   {
      last++;
      block[index].rightIndex = last;
      store_tree2(block, last, tree->rightPtr);
   }

   return;
}



// this implementation stores node information more compactly by specifying
// flags indicating whether the node has left or right children.  This is
// a superior implementation insofar as the block is smallest, and the
// restoration of the tree makes a single sequential pass through the block

int
store_tree3(Node* tree, Node1 block[], int last)
{
   if (tree)
   {
      block[last].data = tree->data;
      block[last].hasLeft = tree->leftPtr ? true : false;
      block[last].hasRight = tree->rightPtr ? true : false;

      last++;

      if (tree->leftPtr)
      {
         last = store_tree3(tree->leftPtr, block, last);
      }

      if (tree->rightPtr)
      {
         last = store_tree3(tree->rightPtr, block, last);
      }

      return last;
   }

   return 0;
}



Node*
restore_tree3(Node1 block[], int& last, int max)
{
   if (last < max)
   {
      Node* n = new Node();
      memset(n, 0, sizeof(Node));

      n->data = block[last].data;

      last++;   
      if (block[last].hasLeft)
      {
         n->leftPtr = restore_tree3(block, last, max);
      }

      if (block[last].hasRight)
      {
         n->rightPtr = restore_tree3(block, last, max);
      }

      return n;
   }

   return 0;
}



enum Direction
{
   LEFT,
   RIGHT,
   NEITHER
};



class StackItem
{
   public:

   StackItem()
      :
      node(0),
      parentIndex(0),
      direction(NEITHER)
   {
   }

   StackItem(Node* n_, int parentIndex_, Direction d_)
      :
      node(n_),
      parentIndex(parentIndex_),
      direction(d_)
   {
   }

   ~StackItem()
   {
   }

   Node*     node;          
   int       parentIndex;
   Direction direction;  
};



class Tree
{
   public:

   Tree()
      :
      count(0),
      root(0)
   {
      // build a simple tree
      root = makeNode('A');
      root->leftPtr = makeNode('B');
      root->rightPtr = makeNode('C');

      Node* B = root->leftPtr;
      B->leftPtr = makeNode('D');
      B->rightPtr = makeNode('E');

      Node* C = root->rightPtr;
      C->leftPtr = makeNode('F');
      C->rightPtr = makeNode('G');
   }

   ~Tree()
   {
      // nuke it
   }

   int
   NodeCount()
   {
      return count;
   }

   Node*
   Root()
   {
      assert(root);
      return root;
   }

   // traverse the tree and pack it into an array, fixing up the node pointers
   // such that they are really array indices.  Free the result with delete[];

   Node*
   RecursiveCopyAsBlock1()
   {
      assert(NodeCount());

      Node* result = 0;

      if (NodeCount() == 0)
      {
         return 0;
      }

      // create a block big enough to hold the tree.
      result = new Node[NodeCount()];
      memset(result, 0, sizeof(Node) * NodeCount());

      int last = 0;
      store_tree2(result, last, Root());

      return result;
   }



   Node1*
   RecursiveCopyAsBlock2()
   {
      assert(NodeCount());

      Node1* result = 0;
      if (NodeCount() == 0)
      {
         return 0;
      }

      result = new Node1[NodeCount()];
      memset(result, 0, sizeof(Node1) * NodeCount());

      
      
   Node*
   IterativeCopyAsBlock()
   {
      assert(NodeCount());

      Node* result = 0;

      if (NodeCount() == 0)
      {
         return 0;
      }

      // create a block big enough to hold the tree.
      result = new Node[NodeCount()];
      memset(result, 0, sizeof(Node) * NodeCount());

      // here we use a stack to keep track of the nodes, the index of the
      // node's parent node, and the on which link of the parent the node
      // appears.  Use of a stack and the order in which we push nodes
      // results in a preorder traversal.
      //
      // If we were to use a queue instead of a stack, we would get a
      // level-order traversal, and also better locality of reference for
      // large trees.
      // 
      // For the stack-based implementation, fixing up the links on the parent
      // node may require that we back-access the array all the way to the
      // begining (to fix up the links from the root node).
      // 
      // The locality of reference for the stack-based implementation worsens
      // as the stack deepens.
      // 
      // For a queue-based implementation, fixing up the parent links may
      // back-access the array as far as the span between the node and the
      // level preceeding it (where it's parent is).
      // 
      // So the locality of reference for the queue-based implementation
      // worsens with the width of the tree.

      stack< StackItem > s;
      int last = 0;

      s.push(StackItem(Root(), last, NEITHER));
      while (!s.empty())
      {
         StackItem si = s.top();
         s.pop();

         assert(si.node);

         result[last].data = si.node->data;

         // fix up the links on the parent node
         if (si.direction == LEFT)
         {
            result[si.parentIndex].leftIndex = last;
         }
         else if (si.direction == RIGHT)
         {
            result[si.parentIndex].rightIndex = last;
         }

         if (si.node->leftPtr)
         {
            s.push(StackItem(si.node->leftPtr, last, LEFT));
         }
         if (si.node->rightPtr)
         {
            s.push(StackItem(si.node->rightPtr, last, RIGHT));
         }

         last++;
      }
      assert(last == NodeCount());

      return result;
   }
  
   private:

   Node*
   makeNode(char d)
   {
      Node* result = new Node;
      result->data = d;
      result->leftPtr = 0;
      result->rightPtr = 0;

      count++;
      return result;
   }

   Node* root;
   int   count;
};




void _cdecl
main(int argc, char *argv[])
{
   Node* n1 = Tree().RecursiveCopyAsBlock1();
   Node* n2 = Tree().IterativeCopyAsBlock();
   Node* n3 = Tree().RecursiveCopyAsBlock2();
}




   