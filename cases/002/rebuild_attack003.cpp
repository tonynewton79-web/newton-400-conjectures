// Case 002 / Attack 003: self-contained four-variable sweep, C++17.
// g++ -O3 -std=c++17 rebuild_attack003.cpp -o rebuild && ./rebuild
#include <array>
#include <cstdint>
#include <iostream>
#include <stdexcept>
#include <vector>
using namespace std;
constexpr int LIM=418785, LO=10120, M=260;
int cycles(const array<int,6>& g,int m) {
  int64_t sq=0,ad=0;
  for(int i=0;i<6;i++){sq+=int64_t(g[i])*g[i];ad+=int64_t(g[i])*g[(i+1)%6];}
  int64_t num=14LL*m*m-5*sq-2*ad-39LL*m+72;
  if(num<0 || num%2)throw runtime_error("invalid count");
  return int(num/2);
}
int main(){
  vector<uint8_t> seen(LIM+1,0);
  uint64_t evaluations=0;
  for(int m=6;m<=M;m++)
    for(int i=0;i<6;i++)for(int j=i+1;j<6;j++)
      for(int k=j+1;k<6;k++)for(int l=k+1;l<6;l++){
        array<int,6> g{1,1,1,1,1,1};
        const int budget=m-2;
        for(int x=1;x<=budget-3;x++)for(int y=1;y<=budget-x-2;y++)
          for(int z=1;z<=budget-x-y-1;z++){
            int w=budget-x-y-z;
            g[i]=x;g[j]=y;g[k]=z;g[l]=w;
            int n=cycles(g,m);++evaluations;
            if(n>=LO && n<=LIM)seen[n]=1;
          }
      }
  if(evaluations!=2705284800ULL)throw runtime_error("scan size mismatch");
  for(int n=LO;n<=LIM;n++)if(!seen[n]){cerr<<"MISSING "<<n<<"\n";return 1;}
  cout<<"PASS "<<LIM-LO+1<<" consecutive counts in ["<<LO<<","<<LIM
      <<"], evaluated "<<evaluations<<" configurations.\n";
}
