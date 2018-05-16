net = feedforwardnet ([100, 150]);
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';

net.trainFcn = 'traingd';
net.trainParam.epochs=1000;
net.trainParam.lr=.01;
net.trainParam.showWindow=1;
net.trainParam.max_fail=15;

net = train(net,traindata' , labeltrain'); 
testCikis=net(testdata');   
testbasarimtablosu=crosstab(labeltest, round(testCikis)) 
