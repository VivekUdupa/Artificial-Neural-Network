function run()

%     input = [ [0;0;1] [0;1;1] [1;0;1] [1;1;1] ];
      %A to D converter
      input = [  [0.0; 1.0] [0.0625; 1.0] [0.125; 1.0] [0.1875; 1.0] [0.25; 1.0] [0.3125; 1.0] [0.375; 1.0] [0.4375; 1.0]  ];

%     target = [ 0 1 1 0]' ;
    target=[0 0 0 0 0 0 0 0;
            0 0 0 0 1 1 1 1;
            0 0 1 1 0 0 1 1;
            0 1 0 1 0 1 0 1]';

    ep = 100000; %working for A to D
%     ep = 30000;

    a = 0.5; %weights learning rate
    a1_lrn = 0.005; %alpha1(scaling) learning rate
    a2_lrn = 0.005; %alpha1(shifting) learning rate
    mode = 'train' ;
    opt = 1;

    layers = 4;
    dim = [1 12 16 4 ];
%     layers = 3;
%     dim = [2 3 1];

tic;
    [W ,output, alpha_scale, alpha_shift] = my_net(a,ep,mode,layers,input,target,dim,opt,a1_lrn,a2_lrn);
toc;    
    %display results
     input
     target'
     output
     W;
     alpha_scale;
     alpha_shift;
     
    
end



