#include <stdio.h>
#include <stdlib.h> //warnings apo compiler stin malloc

#define NUM_NODES                          100
#define NONE                               9999

#if defined(SLL)
#include "../synch_implementations/cdsl_queue.h"
//#define debug 0
#endif

#if defined(DLL)
#include "../synch_implementations/cdsl_deque.h"
//#define debug 1
#endif

#if defined(DYN_ARR)
#include "../synch_implementations/cdsl_dyn_array.h"
//#define debug 2
#endif

struct _NODE
{
  int iDist;
  int iPrev;
};
typedef struct _NODE NODE;

struct _QITEM{
  int iNode;
  int iDist;
  int iPrev;
  //struct _QITEM *qNext;
};
typedef struct _QITEM QITEM;

//QITEM *qHead = NULL;

#if defined(SLL)
cdsl_sll *qHead;
iterator_cdsl_sll it;
#endif

#if defined(DLL)
cdsl_dll *qHead;
iterator_cdsl_dll it;
#endif

#if defined(DYN_ARR)
cdsl_dyn_array *qHead;
iterator_cdsl_dyn_array it;
#endif

int AdjMatrix[NUM_NODES][NUM_NODES];

int g_qCount = 0;
NODE rgnNodes[NUM_NODES];
int ch;
int iPrev, iNode;
int i, iCost, iDist;

void init_head(){
  #if defined(SLL)
  qHead = cdsl_sll_init();
  #endif

  #if defined(DLL)
  qHead = cdsl_dll_init();
  #endif

  #if defined(DYN_ARR)
  qHead = cdsl_dyn_array_init();
  #endif
}

void print_path (NODE *rgnNodes, int chNode)
{
  if (rgnNodes[chNode].iPrev != NONE)
    {
      print_path(rgnNodes, rgnNodes[chNode].iPrev);
    }
  printf (" %d", chNode);
  fflush(stdout);
}


void enqueue (int iNode, int iDist, int iPrev)
{
  QITEM *qNew = (QITEM *) malloc(sizeof(QITEM));
  //QITEM *qLast = qHead;
  
  if (!qNew) 
    {
      fprintf(stderr, "Out of memory.\n");
      exit(1);
    }
  qNew->iNode = iNode;
  qNew->iDist = iDist;
  qNew->iPrev = iPrev;

  /*qNew->qNext = NULL;
  
  if (!qLast) 
    {
      qHead = qNew;
    }
  else
    {
      while (qLast->qNext) qLast = qLast->qNext;
      qLast->qNext = qNew;
    }*/
  qHead->enqueue(0, qHead, (void *)qNew);
  g_qCount++;
}


void dequeue (int *piNode, int *piDist, int *piPrev)
{
  it = qHead->iter_begin(qHead);

  QITEM *qKill = (QITEM *)qHead->iter_deref(qHead, it);
  if (qHead)
  {
	  *piNode = qKill->iNode;
    *piDist = qKill->iDist;
    *piPrev = qKill->iPrev;
    //qHead = qHead->qNext;
    //free(qKill);
    qHead->remove(0, qHead, qKill);
    g_qCount--;
  }
}


int qcount (void)
{
  return(g_qCount);
}

int dijkstra(int chStart, int chEnd) 
{
  for (ch = 0; ch < NUM_NODES; ch++)
  {
    rgnNodes[ch].iDist = NONE;
    rgnNodes[ch].iPrev = NONE;
  }

  if (chStart == chEnd) 
  {
    printf("Shortest path is 0 in cost. Just stay where you are.\n");
  }
  else
  {
    rgnNodes[chStart].iDist = 0;
    rgnNodes[chStart].iPrev = NONE;
  
    enqueue (chStart, 0, NONE);
      
    while (qcount() > 0)
	  {
	    dequeue (&iNode, &iDist, &iPrev);
      for (i = 0; i < NUM_NODES; i++)
	    {
	      if ((iCost = AdjMatrix[iNode][i]) != NONE)
		    {
          if ((NONE == rgnNodes[i].iDist) || 
              (rgnNodes[i].iDist > (iCost + iDist)))
		      {
		        rgnNodes[i].iDist = iDist + iCost;
		        rgnNodes[i].iPrev = iNode;
		        enqueue (i, iDist + iCost, iNode);
		      }
		    }
	    }
	  }
      
    printf("Shortest path is %d in cost. ", rgnNodes[chEnd].iDist);
    printf("Path is: ");
    print_path(rgnNodes, chEnd);
    printf("\n");
  }

  return 0; //warning apo compiler
}

int main(int argc, char *argv[]) {
  int i,j,k;
  FILE *fp;
  
  if (argc<2) {
    fprintf(stderr, "Usage: dijkstra <filename>\n");
    fprintf(stderr, "Only supports matrix size is #define'd.\n");
  }

  /* open the adjacency matrix file */
  fp = fopen (argv[1],"r");

  /* make a fully connected matrix */
  for (i=0;i<NUM_NODES;i++) {
    for (j=0;j<NUM_NODES;j++) {
      /* make it more sparce */
      fscanf(fp,"%d",&k);
	    AdjMatrix[i][j]= k;
    }
  }

  init_head();
  /* finds 10 shortest paths between nodes */
  for (i=0,j=NUM_NODES/2;i<20;i++,j++) {
			j=j%NUM_NODES;
      dijkstra(i,j);
  }

  //printf("Debug is %d\n", debug);
  exit(0);
}
