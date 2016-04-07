#include <stdio.h>
#include <vector>
#include <algorithm>
#include <map>
#include <cstring>
#define N 875714
using namespace std;
vector<int> arestas[1+N];
vector<int> reverse_arestas[1+N];
vector<int> S;
int visitado[1+N];
int contador[1+N];

bool myfunction (int i,int j) { return (i>j); }

void dfs(int x)
{
  visitado[x] = 1;
  int sz =arestas[x].size();
  for (int j = 0; j < sz; j++)
    if (visitado[arestas[x][j]] == 0)
      dfs(arestas[x][j]);
  S.push_back(x);
}

void dfs_2(int x, int cor)
{
  visitado[x] = cor;
  int sz = reverse_arestas[x].size();
  for (int j = 0; j < sz; j++)
    if (visitado[reverse_arestas[x][j]] == 0)
      dfs_2(reverse_arestas[x][j], cor);
  //  S.push_back(x);
}

int main()
{
  FILE *in = fopen("SCC.txt","r");
  int x,y;

  while(fscanf(in,"%d", &x)!=EOF)
    {
      fscanf(in,"%d", &y);
      arestas[x].push_back(y);
      reverse_arestas[y].push_back(x);
    }
  
  for (int i = 1; i <= N; i++)
    if (visitado[i] == 0)
      dfs(i);
  
  memset(visitado, 0, sizeof(visitado));
  
  int cor = 0;
  
   for (int i = N; i >=1; i--)
     if (visitado[S[i-1]] == 0)
       dfs_2(S[i-1], cor++);
   
   
   for (int i = 1; i <= N; i++)
     contador[visitado[i]]++;

   sort(contador, contador+N+1, myfunction);
   for (int i = 0; i < 5; i++)
     printf("%d ", contador[i]);
     
  
  return 0;
}
