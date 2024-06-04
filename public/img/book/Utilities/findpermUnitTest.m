clear;

A=[4 5 1 3 5 7];
B=[ 4 7 1 1 5 ];

assert(all(A(findperm(A, B))==B));

A=B;

assert(all(A(findperm(A, B))==B));


A={'LEH', 'MER', 'AAPL', 'AMAT', 'LEH'};
B={'MER', 'MER', 'LEH'};

assert(all(strcmp(A(findperm(A, B)), B)));

A=B;

assert(all(strcmp(A(findperm(A, B)), B)));


A=[1 4 3];
B=[6 2 1];

ind=findperm(A, B);

B(ind==0)=[];
ind(ind==0)=[];

assert(all(A(ind)==B));
