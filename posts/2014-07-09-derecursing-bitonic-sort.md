---
title: Derecursing bitonic sort
---

Sorting and searching algorithms are two of the most common areas covered at the start of an undergraduate course in computer science. Traditionally, when covering sorting, such a course might start with bubble sort, before moving on to, say, insertion sort

As part of m

Cuda code to swap within the array

```C
// performs swap within array 
__global__ void swap(int *arr, int sls, int slc, int step_size)
{
	//get index of comparison (ie, we always have len(arr) comparisons, which one are we?)
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

```C
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
			printf("cudaThreadSynchronize error: %s\n", cudaGetErrorString(err));	
	}		
}
```