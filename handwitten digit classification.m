data=load('./data/NNdata.mat'); % load training and testing data 


train5=data.train5;  % class 5 training data for digit 5
train9=data.train9;  % class 9 training data for digit 9


test5=data.test5; % test data for digit 5
test9=data.test9; % test data for digit 9 



traindata=[train5  train9];
trainlabel=[5*ones(1,600), 9*ones(1,600)];

% Find the optimal K
totalerror=[];
for ks=1:20
  error=0;

      for t5=1:1200
           temp5label=trainlabel;
           temp5=traindata;
           traindata(:,t5)=[];
           trainlabel(t5)=[];
           y5 = nearNeigh(traindata,temp5(:,t5) , trainlabel,ks); % find neares
       
             if(y5~=temp5label(t5))
                error++;
             end % end if
             
           traindata=temp5;
           trainlabel=temp5label;
      end % end iterating samples
      
  totalerror=[totalerror error];

  disp(strcat('For k= ', num2str(ks) ,' Error = ' , num2str(error)));
 
end   %k for loop 

kvalues=1:20;
temperror=totalerror;
minerror=find(temperror==min(temperror));
bestk=kvalues(minerror);
disp(strcat('Best k= ', num2str(bestk)));


%% Get classification accuracy for best k
error5=0;
error9=0;

testout5 = nearNeigh(traindata,test5 , trainlabel,bestk); % find neares
testout9 = nearNeigh(traindata,test9 , trainlabel,bestk); % find neares

 for i=1:292
    
     if(testout5(i)~=5)
       error5++;
     end % end if
     if(testout9(i)~=9)
       error9++;
     end % end ifd 
 end%% end for 
 
 accuracy=((584-(error5+error9))/584)*100;

disp(strcat('Accuracy= ', num2str(accuracy),'%'));



%% Print chart between different values of keys (x) and Errors (y) 
figure; hold on;
plot(kvalues,totalerror);
set(gca, "ylabel", text("string", "Error", "fontsize", 25));
set(gca, "xlabel", text("string", "K values", "fontsize", 25));
set(gca, "xtick", [1:20]);


