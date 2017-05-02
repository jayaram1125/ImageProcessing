function [output]= GaussianFilter(image,N,gker)
    [imr,imc] = size(image);
       
     padsize = floor(N/2);
  
     %padding the image 
     image2 = uint8(zeros(imr+2*padsize,imc+2*padsize)); 
     image2((padsize+1):(padsize+imr),(padsize+1):(padsize+imc)) = image;
 
     startrow = ceil(N/2); 
     endrow = imr+2*padsize - padsize;
   
     startcol =ceil(N/2);
     endcol = imc+2*padsize -padsize;
     
     output = zeros(size(image));
     Imagtemp = double(image2);
     
     for i = startrow:endrow
         for j = startcol:endcol
               subimage = Imagtemp((i-startrow+1):(i+startrow-1),(j-startcol+1):(j+startcol-1));
               output(i,j)=sum(sum(subimage.*gker));
         end 
     end    
end    
  