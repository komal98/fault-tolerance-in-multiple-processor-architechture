%Generate Symmetric Networks Of N nodes
for N=6:15%can be of any length we are taking 9 nodes
    t=floor((N-1)/2);
    % Generate A Random Syndromes
    a=round(rand(N));
    %This is to assign number 5 if unit i does not test unit j
    %and to assign a(i,i) to 0 since the assumption is unit i
    %is assumed to test itself as a fault free
    for i=1:N
        for j=1:N
            if mod((j-1)-(i-1),N)>t
                a(i,j)=5;
            elseif i==j
                a(i,j)=0;
            end
        end
    end
end 
 %The syndrome is now
 The_Random_Syndrome_is=a;
 %Generate The Maximum Allowable number of faults
 The_Maximum_numberofFaults_is=t;
 i=0;
 B=zeros(N,N);%Generate an empty table
 %The Original Algorithm To Construct the Tables
 for count1=1:N
     j=i; k=mod(i+1,N); Nf=0;
     while (Nf<t &&abs(k-i)>0),
         if a(j+1,k+1)==1
             B(i+1,k+1)=1;
             Nf=Nf+1;
         else
             j=k;
         end
         k=mod(k+1,N);
     end
     i=i+1;
 end
 The_Generated_Tables_are=B;
 %check if the number of equal tables are >=n-t
 for i=1:N-1
     count=0;
     for j=i:N
         if B(i,:)==B(j,:)
             count=count+1;
         end
     end
     if count>=N-t
         i1=i;
         break
     end
 end
 count;
 if count<N-t
     disp('The number of faults is > t')
     disp('The Diagnosis Algorithm Does not work')
 else
     c1=zeros(1,t);
     count1=0;
     for c=1:N
         if B(i1,c)==1
             c1(count1+1)=c-1;
             count1=count1+1;
         end
     end
     %Display the faulty units of origional algorithm
     disp('The faulty servers are: ')
     c1(1,1:count1)
 end
 %The Accelerated Algorithm
 for i2=1:N
     V(i2)=sum(B(:,i2));
 end
 count3=0;