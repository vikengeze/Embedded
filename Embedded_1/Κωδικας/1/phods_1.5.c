/*Parallel Hierarchical One-Dimensional Search for motion estimation*/
/*Initial algorithm - Used for simulation and profiling             */

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define N 144     /*Frame dimension for QCIF format*/
#define M 176     /*Frame dimension for QCIF format*/
#define Bx 144      /*X Block size*/
#define By 176      /*Y Block size*/
#define p 7       /*Search space. Restricted in a [-p,p] region around the
                    original location of the block.*/

void read_sequence(int current[N][M], int previous[N][M])
{ 
	FILE *picture0, *picture1;
	int i, j;

	if((picture0=fopen("akiyo0.y","rb")) == NULL)
	{
		printf("Previous frame doesn't exist.\n");
		exit(-1);
	}

	if((picture1=fopen("akiyo1.y","rb")) == NULL) 
	{
		printf("Current frame doesn't exist.\n");
		exit(-1);
	}

  /*Input for the previous frame*/
  for(i=0; i<N; i++)
  {
    for(j=0; j<M; j++)
    {
      previous[i][j] = fgetc(picture0);
    }
  }

  /*Input for the current frame*/
  for(i=0; i<N; i++)
  {
    for(j=0; j<M; j++)
    {
      current[i][j] = fgetc(picture1);
    }
  }

  fclose(picture0);
  fclose(picture1);
}


void phods_motion_estimation(int current[N][M], int previous[N][M],
    int vectors_x[N/Bx][M/By],int vectors_y[N/Bx][M/By])
{
  struct timeval Arxi;
  struct timeval Telos;

  gettimeofday(&Arxi, NULL);

  int x, y, i, j, k, l, p1, p2, q2, distx, disty, S, min1, min2, bestx, besty, min;

  distx = 0;
  disty = 0;

  /*Initialize the vector motion matrices*/
  for(i=0; i<N/Bx; i++)
  {
    for(j=0; j<M/By; j++)
    {
      vectors_x[i][j] = 0;
      vectors_y[i][j] = 0;
    }
  }
  min = 255*Bx*By;  //exw parakatw 2 grammes pou to upologizoun polles fores, opote to upologizw twra 1 k meta apla kanw anathesi
  
  /*For all blocks in the current frame*/
  for(x=0; x<N/Bx; x++)
  {
    for(y=0; y<M/By; y++)
    {
      S = 4;

      while(S > 0)
      {
        min1 = min2 = min;

        /*For all candidate blocks in X and Y dimension*/
        for(i=-S; i<S+1; i+=S)     
        {
          //printf("%d %d\n", S, i);
          distx = 0;
          disty = 0;

          /*For all pixels in the block*/
          for(k=0; k<Bx; k++)     
          {
            for(l=0; l<By; l++)
            {
              p1 = current[Bx*x+k][By*y+l];

              if((Bx*x + vectors_x[x][y] + i + k) < 0 ||
                  (Bx*x + vectors_x[x][y] + i + k) > (N-1) ||
                  (By*y + vectors_y[x][y] + l) < 0 ||
                  (By*y + vectors_y[x][y] + l) > (M-1))
              {
                p2 = 0;
              } else {
                p2 = previous[Bx*x+vectors_x[x][y]+i+k][By*y+vectors_y[x][y]+l];
              }

              distx += abs(p1-p2);

              if((Bx*x + vectors_x[x][y] + k) <0 ||
                  (Bx*x + vectors_x[x][y] + k) > (N-1) ||
                  (By*y + vectors_y[x][y] + i + l) < 0 ||
                  (By*y + vectors_y[x][y] + i + l) > (M-1))
              {
                q2 = 0;
              } else {
                q2 = previous[Bx*x+vectors_x[x][y]+k][By*y+vectors_y[x][y]+i+l];
              }

              disty += abs(p1-q2);
            }
          }

          if(distx < min1)
          {
            min1 = distx;
            bestx = i;
          }

          if(disty < min2)
          {
            min2 = disty;
            besty = i;
          }
        }

        S = S/2;
        vectors_x[x][y] += bestx;
        vectors_y[x][y] += besty;
      }
    }
  }

  //Time + printers

  gettimeofday(&Telos, NULL);
  long int Resta = 0;
  if (Telos.tv_sec == Arxi.tv_sec){
    Resta = Telos.tv_usec - Arxi.tv_usec;
  }
  else{
    Resta = (Telos.tv_sec - Arxi.tv_sec)*1000000 + (Telos.tv_usec - Arxi.tv_usec);
  }

  printf("Execution Time: %ld μsec\n", Resta);

/*  for(x=0; x<N/Bx; x++)
  {
    for(y=0; y<M/By; y++)
    {
      printf("%d ", vectors_x[x][y]);
    }
    printf("\n");
  }

  printf("\n");

  for(x=0; x<N/Bx; x++)
  {
    for(y=0; y<M/By; y++)
    {
      printf("%d ", vectors_y[x][y]);
    }
    printf("\n");
  }
  printf("\n");*/
}

int main()
{  
  int current[N][M], previous[N][M], motion_vectors_x[N/Bx][M/By],
      motion_vectors_y[N/Bx][M/By], i, j;

  read_sequence(current,previous);
  phods_motion_estimation(current,previous,motion_vectors_x,motion_vectors_y);

  return 0;
}