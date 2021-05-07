function numberPlateExtraction
load imgfildata;

% f=imread('example\carplate16.jpg');
% imshow(f);

[FileName,PathName] = uigetfile({'*.jpg'});
f=strcat(PathName,FileName); %Give system a path of picture to recognize

picture=imread(f); %Read Image

pictureforRecog=picture;

[rr,cc]=size(picture);%
picture=imresize(picture,[200 300]);  %Resizing the Image 
picture=rgb2gray(picture); % Image to Grey scale for further process

if size(picture,3)==3
  picture=rgb2gray(picture);
end
se=strel('rectangle',[5,5]);
a=imerode(picture,se);
figure
imshow(a);
b=imdilate(a,se);
threshold = graythresh(picture);
picture =~im2bw(picture,threshold);
picture = bwareaopen(picture,8);
imshow(picture)
if cc>1000
    picture1=bwareaopen(picture,3500);
else
picture1=bwareaopen(picture,2000);
end
% figure
% imshow(picture1),title('scaned image')%scaned immaagee taken from dataset
picture2=picture-picture1;

% figure
% imshow(picture2)
picture2=bwareaopen(picture2,200);
hold on;

% figure
% imshow(picture2),title('2nd Picture')

[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
pause(1)
for n=1:size(propied,1)
  rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',4)
end
hold off

%figure
final_output=[];
t=[];
for n=1:Ne
  [r,c] = find(L==n);
  n1=picture(min(r):max(r),min(c):max(c));
  n1=imresize(n1,[42,24]);
  %imshow(n1)
  pause(0.5)
  x=[ ];

totalLetters=size(imgfile,2);



 for k=1:totalLetters
    
    y=corr2(imgfile{1,k},n1);
    x=[x y];
    
 end
 t=[t max(x)];
 if max(x)>.5
 z=find(x==max(x));
 
 
 out=cell2mat(imgfile(2,z));
 
 %disp(out);

%final_output=[final_output  out];
end
end


%picture=imread('example\carplate4.jpg');
%imshow(f);
pictureforRecog=imresize(pictureforRecog,[400 NaN]);
g=rgb2gray(pictureforRecog);

g=medfilt2(g,[3 3]);
se=strel('disk',1);
gi=imdilate(g,se);
ge=imerode(g,se);
gdiff=imsubtract(gi,ge);
gdiff=mat2gray(gdiff);
gdiff=conv2(gdiff,[1 1;1 1]);
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1);
B=logical(gdiff);
er=imerode(B,strel('line',50,0));
out1=imsubtract(B,er);
F=imfill(out1,'holes');

H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',3,90));
final=bwareaopen(H,100);
Iprops=regionprops(final,'BoundingBox','Image');

NR=cat(1,Iprops.BoundingBox);

r=controlling(NR);

if ~isempty(r)
    I={Iprops.Image};
    noPlate=[];
    for v=1:length(r)
        N=I{1,r(v)};
        letter=readLetter(N);
        while letter=='O' || letter=='0'
            if v<=3
                letter='O';
            else
                letter='0';
            end
            break;
        end
        noPlate=[noPlate letter];
    end 
    
    %%
    %Inserting Number plates reg in VehicleInfo database
    prefs = setdbprefs('DataReturnFormat');
setdbprefs('DataReturnFormat','table')

conn = database('LPR','','');
columname = {'REGNO','DATETIME'};

formatOut = 'yyyy-mm-dd HH:MM:ss';

time = datestr(now,formatOut);

dataTobeInserted = {noPlate time};
datainsert(conn,'VehicleInfo',columname,dataTobeInserted);

    
    
    
    
    
    %%
    %Stolen Vehicles
    
    prefs = setdbprefs('DataReturnFormat');
    setdbprefs('DataReturnFormat','table')

    conn = database('LPR','','');
    
    Whatyouwanttosearch='Select REGNO from StolenVehicle where REGNO=''regno''';
    SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);
    curs = exec(conn,SearchString); 
    curs = fetch(curs);
    data = curs.Data;
    %disp(data);
    nullQuery=strcmp(data,'No Data');
    
 
    if nullQuery==1
        CheckRegVehicle(noPlate);
    else
         C = table2cell(data);
        %celldisp(C);
         y=strings(size(C));
        [y{:}]=C{:};
        compareNoplate=strcmp(noPlate,y);
    
        if compareNoplate==1
         Whatyouwanttosearch='Select * from StolenVehicle where REGNO=''regno''';
          SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);

         curs = exec(conn,SearchString); 
         curs = fetch(curs);
         data = curs.Data;
         %disp(data);
         
         C = table2cell(curs.Data);
    f = figure;
            axes
            title('All Stolen Cars')
            set(gca, 'visible', 'off')
            set(gca,'FontSize',20)
            set(findall(gca, 'type', 'text'), 'visible', 'on')
    uit = uitable(f);
    d = C;
    uit.Data = d;
    uit.ColumnName = {'OWNER','CNIC','REGNO','CHASSISNO','MAKER','MAKE'};
    uit.Position = [0 150 550 200];
         end   
    end
    
 %%   
    
   
else
    msgbox('Unable to extract the characters from the number plate.\n The characters on the number plate might not be clear or touching with each other or boundries');
    
end
end

function [] = CheckRegVehicle(noPlate) 

    prefs = setdbprefs('DataReturnFormat');
    setdbprefs('DataReturnFormat','table')

    conn = database('LPR','','');
    Whatyouwanttosearch='Select REGNO from RegisteredVehicle where REGNO=''regno''';
    SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);
    curs = exec(conn,SearchString); 
    curs = fetch(curs);
    data = curs.Data;
    %disp(data);
    found=strcmp(data,'No Data');
    if found==1
     msgbox('Your Vehicle is not Registered');
   
    else
    C = table2cell(data);
    %celldisp(C);
    y=strings(size(C));
    [y{:}]=C{:};
    compareNoplateForRegistered=strcmp(noPlate,y);
        if compareNoplateForRegistered==1
            conn = database('LPR','','');
            Whatyouwanttosearch='Select * from RegisteredVehicle where REGNO=''regno''';
            SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);
            curs = exec(conn,SearchString); 
            curs = fetch(curs);
            data = curs.Data;
            %disp(data);
    
            C = table2cell(curs.Data);
            f = figure;
            
          
           
            uit = uitable(f);
           
            axes
            title('All Registered Cars')
            set(gca, 'visible', 'off')
            set(gca,'FontSize',20)
            set(findall(gca, 'type', 'text'), 'visible', 'on')
            d = C;
            uit.Data = d;
           
            uit.ColumnName = {'OWNER','CNIC','ADDRESS','REGNO','MAKE','ENGINESIZE','COLOR','CHASSISNO','MAKER'};
            uit.Position = [0 150 550 200];
        end
    end
end   
