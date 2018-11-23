function [stable, test] = store_path()
%This function stores the file name of each image pattern in img(i)
%variable
    
    %Stable state patterns
%    img = {'A.png','C.png','E.png','F.png','H.png','I.png','K.png','L.png','M.png','R.png','S.png','T.png','U.png','X.png'};
    stable = dir('stable/*.png');
%     stable = [char(stable(:).name)];
    
    %Test patterns
    test = dir('test/*.png');
%     test = [char(test(:).name)]

end %function




%     img(1,:) = 'A.png';
%     img(2,:) = 'C.png';
%     img(3,:) = 'E.png';
%     img(4,:) = 'F.png';
%     img(5,:) = 'H.png';
%     img(6,:) = 'I.png';
%     img(7,:) = 'K.png';
%     img(8,:) = 'L.png';
%     img(9,:) = 'M.png';
%     img(10,:) ='R.png';
%     img(11,:) ='S.png';
%     img(12,:) ='T.png';
%     img(13,:) ='U.png';
%     img(14,:) ='X.png';