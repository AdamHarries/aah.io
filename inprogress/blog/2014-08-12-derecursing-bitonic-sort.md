---
title: Derecursing bitonic sort
---

Sorting and searching algorithms are two of the most common areas covered at the start of an undergraduate course in computer science. Traditionally, however, when covering sorting algorithms, most courses only really cover serial implementations. There are however, a wide variety of sorting algorithms designed specifically to be run in parallel. One such algorithm, which this post looks at, is 

such a course might start with bubble sort, before moving on to, say, insertion sort

As part of m

Bitonic sort traditionally displayed in a network - i.e. lines of computation. Useful for parallel computation, but not for figuring out which processors should be swapping what. Also - recursive version not great for that either! Instead, consider it as sort on hypercube. Use dimensions of hypercube to calculate what should be swapping, and where.

The first comparator index for a swap is given by:

$$ C_i = 2i - i \bmod s $$

And the direction of comparison, which is either $1$ or $0$, for sorting up or down is given by:

$$ D_i = ({i \over {S_s / 2}}  \bmod  S_c) \bmod 2 $$

Cuda code to swap within the array

[link to something here, just in case](http://www.example.com)

``` C
// performs swap within array 
__global__ void swap(int *arr, int sls, int slc, int step_size)
{
	//get index of comparison (ie, we always have len(arr)
	//comparisons, which one are we?)
	int cid = threadIdx.x;
	//get index of first comparison element
	int aid = ((cid*2)-(cid%(step_size)));
	//get direction of comparison
	int d = ((cid/(sls/2))%slc)%2; //1 up, 0 down
	//compare and swap:
	if((arr[aid]<arr[aid+step_size])==d)
	{
		int temp = arr[aid+step_size];
		arr[aid+step_size] = arr[aid];
		arr[aid] = temp;
	}
}
```

``` C
for(sls=2;sls<=n; sls*=2)
{
	//loop over swap distances
	//aka, merge up subhypercubes, pseudo-recursively
	for(dist=sls/2;dist>=1;dist=dist/2)
	{
		//launch swap kernel
		swap<<<1,n/2>>>(cu_arr, sls,n/sls, dist);
		//synchronise threads ready to launch again
		cudaError_t err = cudaThreadSynchronize();
		//get errors with synchronisation
		if( err != cudaSuccess)
			printf("cudaThreadSynchronize error: %s\n", \
			cudaGetErrorString(err));	
	}		
}
```

Here is an inline note.^[Inlines notes are easier to write, since
you don't have to pick an identifier and move down to type the
note.]