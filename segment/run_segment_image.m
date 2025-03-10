%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% implement the photo segmentation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath .
nowdirection = pwd();
all = dir(nowdirection);
cd ..
if exist('output','dir') == 0
mkdir output
end
cd (nowdirection)
name=length(all);
 findjpg1=0;
 findpng1=0;
 for  ii=3:name
    
    pictures = all(ii).name;
    name = string(pictures);
    findjpg = strfind(pictures,'.jpg');
    findpng = strfind(pictures,'.png');
    if sum(findjpg) > 0 || sum(findpng) > 0
    name
        I = segment_image(pictures);
   

     % ontput
    cd ..
    cd output
    strresult = "result_";
    filename = strcat(strresult,name);
    imwrite (I,filename);
    cd ..
    cd (nowdirection)
   
    else        
    end
    
    findjpg1=sum(findjpg)+findjpg1;
    findpng1=sum(findpng)+findpng1;
 end
 if findjpg1==0  && findpng1==0
     fprintf("please put image in this file")
 end

