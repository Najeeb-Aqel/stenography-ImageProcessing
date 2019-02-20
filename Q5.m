img1 = imread('image1.jpg');
img2 = imread('image2.jpg');

img2 = rgb2gray(img2);
imwrite(image2,'original2.jpg');

img1red = img1(:,:,1);
img1green = img1(:,:,2);
img1blue = img1(:,:,3);

imgsize = size(img2); 


merge(img1red,img1green,img1blue,img2,imgsize);

function merge(img1red,img1green,img1blue,img2,imgsize)

    for i=1:imgsize(1)
        for j=1:imgsize(2)
            img1redbit = decimalToBinaryVector(img1red(i,j),8); 
            img1greenbit = decimalToBinaryVector(img1green(i,j),8); 
            img1bluebit = decimalToBinaryVector(img1blue(i,j),8); 
            img2bit = decimalToBinaryVector(img2(i,j),8); 
            
            for k=1:2
               img1redbit(k) = img2bit(k);
            end
            for k=3:5
               img1greenbit(k-2) = img2bit(k);
            end
            for k=6:8
               img1bluebit(k-5) = img2bit(k);
            end
           
            red = num2str(img1redbit);
            red(isspace(red)) = '';
            img1red(i,j) = bin2dec(red);
            
            green = num2str(img1greenbit);
            green(isspace(green)) = '';
            img1green(i,j) = bin2dec(green);
            
            blue = num2str(img1bluebit);
            blue(isspace(blue)) = '';
            img1blue(i,j) = bin2dec(blue);
            
        end 
        
    end 
    merged = cat(3,img1red,img1green,img1blue);
    imwrite(merged, 'merged2.jpg');

end 



