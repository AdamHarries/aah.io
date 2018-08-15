---
title: How linear algebra turns up in unexpected places.
---

#Linear algebra

> **Dutch Gunderson**: Who are you and how did you get in here? 

> **Frank**: I'm a locksmith. And, I'm a locksmith.

Linear algebra is an incredible tool. [todo, write more about why Haskell is cool.] 

# Linear algebra and graph theory
The first of our "unusual domains" for linear algebra is the generally discrete world of Graph Theory. Graph theory is a fantastic area of maths that's been studied (in some form or another) since at least the early 1700's, and is an invaluable tool for any competent computer scientist or programmer. Graph theory studies the connections, called edges, between objects, called vertices. Both vertices and edges can carry information about the connection. 
For example, we could model a social network as a graph: each vertex representing a person, and each edge the relationship between two people. A vertex in our social network graph would therefore store information such as the persons name, age, gender etc, while an edge in the graph would store information such as the date of first friendship, or how often they message each other. 

Using graphs to model problems such as this allows us to use all the techniques that graph theory has to offer to analyse the problem. As we'll see later, by modelling the problem as a graph, we'll also be able to bring the full power of linear algebra to bear on the problem too.

## Standard graph theory - in Haskell
 Let's begin by considering the following fairly simple graph:

![](../../images/linear_algebra_graph.png)

A reasonable and efficient data representation for a graph might look something like the following:^[I'm using Haskell for conciseness, and because I like it, however nothing here is Haskell specific, and could be translated into your favourite language.]

```haskell
data Graph a b = Graph {
    verticies    ::    Array Int a,
    edges        ::    Array (Int, Int) (Maybe b)
} deriving (Show)
```

Our "vertices" components stores an association^[Essentially a map, however we're using an Array here, as we'll only be indexing using integers, but we'll get to that later.] between vertex identities, and their data. Our "edges" component is even simpler - it simply defines a two dimensional array which stores whether there is an edge between vertices $i$ and $j$. The contents type (`Maybe b`) reflects this - there may be an edge between $i$ and $j$, in which case there will be data `b` or else there will be nothing.

Using our data representation, the Haskell code describing our graph looks like this:

```haskell
vertexArray :: Array Int Int
vertexArray = array (0,3) [(x,x) | x<-[0..3]]

edgeArray :: Array (Int, Int) (Maybe Int)
edgeArray =  noEdges // graphEdges where
    noEdges = array ((0,0),(3,3)) [((i,j),Nothing) | i<-[0..3],j<-[0..3]]
    graphEdges = zip [(0,3),(0,1),(1,1),(1,2),(2,0),(2,3),(3,1),(3,2)] 
                     (repeat (Just 1))
	
simpleGraph :: Graph Int Int 
simpleGraph = Graph vertexArray edgeArray
```

From here, we can continue to define some simple operations on our graph. For example, to determine whether there is an edge from vertex $i$ to $j$ we might write:

```haskell
edgeExists :: Graph a b -> Int -> Int -> Bool
edgeExists (Graph _ e) i j = case e ! (i,j) of
    Just _ -> True
    Nothing -> False
```

This example 


A slightly more complex algorithm, depth first search might be implemented as follows:



- holy shit, can you consider n-connection hyper graphs in terms of linear algebra

# Linear algebra and loop parallelisation

# Linear algebra and semirings