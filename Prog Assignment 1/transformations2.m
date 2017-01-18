%function 
img = imread('pic.png');
img = double(img);
[nRows,nCols] = size(img); 

shear = [ 1 2; 0 1];
rotate = [cosd(45) -sind(45); sind(45) cosd(45)];
shearedimg = zeros(nRows,nCols);

for i = 1 : nRows
    for j = 1 : nCols
        
        %Applying shear first
        x2 = shear(1,1)*i + shear(1,2)*j;
        y2 = shear(2,1)*i + shear(2,2)*j;
        shearedImg(x2,y2) = img(i,j);
    end
end        

%Applying rotation next


A=shearedImg;

x1=zeros([size(A,1)*size(A,2) 1]);
x2=zeros([size(A,2)*size(A,1) 1]);

%Specify the degree
deg=45;
%Change the image size
C=uint8(zeros([size(A,1) size(A,2) 3 ]));

m=1;
%Find the midpoint
midx=ceil((size(C,1)+1)/2);
midy=ceil((size(C,2)+1)/2);

for i=1:size(A,1)
    %translating to center for rotation
    i1=i-midx;
    for j=1:size(A,2)
        %convert from cartesian to polar
        [t,r]=cart2pol(i1,j-midy);
        %Convert from radians to degree and add the degree value
        t1=radtodeg(t)+deg;
        %Convert from degree to radians
        t=degtorad(t1);
        %Convert to Cartesian Co-ordinates
        [x,y]=pol2cart(t,r);
        x1(m)=round(x+midx);
        x2(m)=round(y+midy);
       
         
        m=m+1;
       
       
       
    end
   
end
%check whether the values are within the image size.
x1(find(x1 < 1))=1;
x2(find(x2 < 1))=1;

n=1;
for i=1:size(A,1)
    for j=1:size(A,2)
        C(x1(n),x2(n),:)=A(i,j,:);
       
        n=n+1;
    end
   
end

%Rotation ends.
%Next we do magnification


imshow(C);