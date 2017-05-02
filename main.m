function main()
  images={'img01.jpg'};
  [row,col]=size(images);
  for i=1:col
     charimage = char(images(i));
     imageread = imread(charimage); 
     [numrowpix,numcolpix,colorchannels] = size(imageread);
     if colorchannels>1
        image = rgb2gray(imageread);
     else   
        image = imageread;
     end
     sigma = 0.5;
     N = 3;
     index = -floor(N/2):floor(N/2);
     [x,y] = meshgrid(index,index);
     gker = exp(-(x.^2+y.^2)/(2*sigma^2));
     gker = gker./sum(gker(:));
     blurredimage = GaussianFilter(image,N,gker);
     [Ix,Iy,Io,Ixy] = EdgeDetection(blurredimage);
     threshold = 5000;
     Response = HarrisCornerDetection(Ix,Iy,threshold,gker);
     [r,c]=find(Response);
      imshow(image);
      hold on
      plot(c,r,'ro');
  end 
end
 