clear all
imagein = double(imread('3096_colorPlane.jpg'));
[height, width, z]=size(imagein);
data = zeros(height*width,7);
idx = 1;

%create feature matrix
for r = 1:height
    for c = 1:width
        data(idx,:)=[r, c, r/height, c/width, imagein(r, c, 1), imagein(r, c, 2), imagein(r, c, 3)];
        idx = idx + 1;
    end
end

%normalize data
data(:,3:7) = normalize(data(:,3:7),'range');

ind2 = kmeans(data(:,3:7),2);
ind3 = kmeans(data(:,3:7),3);
ind4 = kmeans(data(:,3:7),4);
ind5 = kmeans(data(:,3:7),5);
gmind2 = zeros(height*width,1);
gmind3 = zeros(height*width,1);
gmind4 = zeros(height*width,1);
gmind5 = zeros(height*width,1);
gm2 = fitgmdist(data(:,3:7),2);
gm3 = fitgmdist(data(:,3:7),3);
gm4 = fitgmdist(data(:,3:7),4);
gm5 = fitgmdist(data(:,3:7),5);
data2 = [data(:,1:7) ind2];
data3 = [data(:,1:7) ind3];
data4 = [data(:,1:7) ind4];
data5 = [data(:,1:7) ind5];
image2 = zeros(height, width,3);
image3 = zeros(height, width,3);
image4 = zeros(height, width,3);
image5 = zeros(height, width,3);
MAPimage2 = zeros(height, width,3);
MAPimage3 = zeros(height, width,3);
MAPimage4 = zeros(height, width,3);
MAPimage5 = zeros(height, width,3);


%Calculate MAP criteria
%k = 2

m2criteria1=gm2.ComponentProportion(1)*mvnpdf(data2(:,3:7),gm2.mu(1),gm2.Sigma(:,:,1));
m2criteria2=gm2.ComponentProportion(2)*mvnpdf(data2(:,3:7),gm2.mu(2),gm2.Sigma(:,:,2));

m3criteria1=gm3.ComponentProportion(1)*mvnpdf(data3(:,3:7),gm3.mu(1),gm3.Sigma(:,:,1));
m3criteria2=gm3.ComponentProportion(2)*mvnpdf(data3(:,3:7),gm3.mu(2),gm3.Sigma(:,:,2));
m3criteria3=gm3.ComponentProportion(3)*mvnpdf(data3(:,3:7),gm3.mu(3),gm3.Sigma(:,:,3));

m4criteria1=gm4.ComponentProportion(1)*mvnpdf(data4(:,3:7),gm4.mu(1),gm4.Sigma(:,:,1));
m4criteria2=gm4.ComponentProportion(2)*mvnpdf(data4(:,3:7),gm4.mu(2),gm4.Sigma(:,:,2));
m4criteria3=gm4.ComponentProportion(3)*mvnpdf(data4(:,3:7),gm4.mu(3),gm4.Sigma(:,:,3));
m4criteria4=gm4.ComponentProportion(4)*mvnpdf(data4(:,3:7),gm4.mu(4),gm4.Sigma(:,:,4));

m5criteria1=gm5.ComponentProportion(1)*mvnpdf(data5(:,3:7),gm5.mu(1),gm5.Sigma(:,:,1));
m5criteria2=gm5.ComponentProportion(2)*mvnpdf(data5(:,3:7),gm5.mu(2),gm5.Sigma(:,:,2));
m5criteria3=gm5.ComponentProportion(3)*mvnpdf(data5(:,3:7),gm5.mu(3),gm5.Sigma(:,:,3));
m5criteria4=gm5.ComponentProportion(4)*mvnpdf(data5(:,3:7),gm5.mu(4),gm5.Sigma(:,:,4));
m5criteria5=gm5.ComponentProportion(5)*mvnpdf(data5(:,3:7),gm5.mu(5),gm5.Sigma(:,:,5));

%Perform MAP classification using each GMM
for i=1:length(m2criteria1)
    if m2criteria1(i)>m2criteria2(i)
        gmind2(i)=1;
    else
        gmind2(i)=2;
    end
end
data2=[data2 gmind2];

for i=1:length(m3criteria1)
    if m3criteria1(i)>m3criteria2(i) && m3criteria1(i)>m3criteria3(i)
        gmind3(i)=1;
    elseif m3criteria2(i)>m3criteria1(i) && m3criteria2(i)>m3criteria3(i)
        gmind3(i)=2;
    else
        gmind3(i)=3;
    end
end
data3=[data3 gmind3];

for i=1:length(m4criteria1)
    if m4criteria1(i)>m4criteria2(i) && m4criteria1(i)>m4criteria3(i) && m4criteria1(i)>m4criteria4(i)
        gmind4(i)=1;
    elseif m4criteria2(i)>m4criteria1(i) && m4criteria2(i)>m4criteria3(i)&& m4criteria2(i)>m4criteria4(i)
        gmind4(i)=2;
    elseif m4criteria3(i)>m4criteria1(i) && m4criteria3(i)>m4criteria2(i)&& m4criteria3(i)>m4criteria4(i)
        gmind4(i)=3;
    else
        gmind4(i)=4;
    end
end
data4=[data4 gmind4];

for i=1:length(m5criteria1)
    if m5criteria1(i)>m5criteria2(i) && m5criteria1(i)>m5criteria3(i) && m5criteria1(i)>m5criteria4(i)&& m5criteria1(i)>m5criteria5(i)
        gmind5(i)=1;
    elseif m5criteria2(i)>m5criteria1(i) && m5criteria2(i)>m5criteria3(i) && m5criteria2(i)>m5criteria4(i) && m5criteria2(i)>m5criteria5(i)
        gmind5(i)=2;
    elseif m5criteria3(i)>m5criteria1(i) && m5criteria3(i)>m5criteria2(i) && m5criteria3(i)>m5criteria4(i) && m5criteria3(i)>m5criteria5(i)
        gmind5(i)=3;
    elseif m5criteria4(i)>m5criteria1(i) && m5criteria4(i)>m5criteria2(i) && m5criteria4(i)>m5criteria3(i) && m5criteria4(i)>m5criteria5(i)
        gmind5(i)=4;
    else
        gmind5(i)=5;
    end
end
data5=[data5 gmind5];

%now we have MAP classification in index 9 and K means class in index 8

%Change Color based on class
for el=1:height*width
    if data2(el,8)==1
        image2(data2(el,1),data2(el,2),:)=[1 1 0];
    else
        image2(data2(el,1),data2(el,2),:)=[0 1 1];
    end
    if data2(el,9)==1
        MAPimage2(data2(el,1),data2(el,2),:)=[1 1 0];
    else
        MAPimage2(data2(el,1),data2(el,2),:)=[0 1 1];
    end
end
for el=1:height*width
    if data3(el,8)==1
        image3(data3(el,1),data3(el,2),:)=[1 1 0];
    elseif data3(el,8)==2
        image3(data3(el,1),data3(el,2),:)=[0 1 1];
    else
        image3(data3(el,1),data3(el,2),:)=[1 0 0];
    end
    if data3(el,9)==1
        MAPimage3(data3(el,1),data3(el,2),:)=[1 1 0];
    elseif data3(el,9)==2
        MAPimage3(data3(el,1),data3(el,2),:)=[0 1 1];
    else
        MAPimage3(data3(el,1),data3(el,2),:)=[1 0 0];
    end
end
for el=1:height*width
    if data4(el,8)==1
        image4(data4(el,1),data4(el,2),:)=[1 1 0];
    elseif data4(el,8)==2
        image4(data4(el,1),data4(el,2),:)=[0 1 1];
    elseif data4(el,8)==3
        image4(data4(el,1),data4(el,2),:)=[1 0 0];
    else
        image4(data4(el,1),data4(el,2),:)=[0 1 0];
    end
    if data4(el,9)==1
        MAPimage4(data4(el,1),data4(el,2),:)=[1 1 0];
    elseif data4(el,9)==2
        MAPimage4(data4(el,1),data4(el,2),:)=[0 1 1];
    elseif data4(el,9)==3
        MAPimage4(data4(el,1),data4(el,2),:)=[1 0 0];
    else
        MAPimage4(data4(el,1),data4(el,2),:)=[0 1 0];
    end
end
for el=1:height*width
    if data5(el,8)==1
        image5(data5(el,1),data5(el,2),:)=[1 1 0];
    elseif data5(el,8)==2
        image5(data5(el,1),data5(el,2),:)=[0 1 1];
    elseif data5(el,8)==3
        image5(data5(el,1),data5(el,2),:)=[1 0 0];
    elseif data5(el,8)==4
        image5(data5(el,1),data5(el,2),:)=[0 1 0];
    else
        image5(data5(el,1),data5(el,2),:)=[0 0 1];
    end
    
    if data5(el,9)==1
        MAPimage5(data5(el,1),data5(el,2),:)=[1 1 0];
    elseif data5(el,9)==2
        MAPimage5(data5(el,1),data5(el,2),:)=[0 1 1];
    elseif data5(el,9)==3
        MAPimage5(data5(el,1),data5(el,2),:)=[1 0 0];
    elseif data5(el,9)==4
        MAPimage5(data5(el,1),data5(el,2),:)=[0 1 0];
    else
        MAPimage5(data5(el,1),data5(el,2),:)=[0 0 1];
    end
end

figure(1)
imshow(imread('3096_colorPlane.jpg'));
figure(2)
imshow(image2);
figure(3)
imshow(image3);
figure(4)
imshow(image4);
figure(5)
imshow(image5);
figure(6)
imshow(MAPimage2);
figure(7)
imshow(MAPimage3);
figure(8)
imshow(MAPimage4);
figure(9)
imshow(MAPimage5);