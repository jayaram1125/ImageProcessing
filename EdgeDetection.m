function[Ix,Iy,Io,Ixy] = EdgeDetection(image)
  
    %SOBEL Filters
  Gx=[-1,0,1;-2,0,2;-1,0,1];
  Gy=[1,2,1;0,0,0;-1,-2,-1];
  
  [row,col] = size(image);
     im1 = zeros(size(image));
  
   for i=2:row-1
       for j=2:col-1
          gridimage  = image(i-1:i+1,j-1:j+1) ; 
          im1(i,j) = sum(sum(Gx.*gridimage));
       end
   end
   
   Ix = uint8(im1);
   
   im2 = zeros(size(image));
   
   for i=2:row -1
       for j=2:col-1
          gridimage  = image(i-1:i+1,j-1:j+1) ; 
          im2(i,j) = sum(sum((Gy).*(gridimage))) ;
       end
   end
 
   Iy = uint8(im2); 
   
    
   Io = zeros(size(image));
   for i=2:row -1
       for j =2:col -1
           Io(i,j) = atan2(double(Iy(i,j)),double(Ix(i,j)));
       end
   end 
 
   
   Ixy = sqrt(im1.^2+im2.^2);
   
   [mr,mc]=size(Ixy);
   
  for i=2:mr-1
     for j=2:mc-1 
       angle = Io(i,j);
       angle = 180+ (180/pi)*angle;
       if ((angle <22.5 &&angle >157.5) || (angle>337.5) || (angle < 202.5))
           %Non max supression in horizontal direction 0 degrees
            if(Ixy(i-1,j)> Ixy(i,j) && Ixy(i+1,j)> Ixy(i,j))
                Ixy(i,j)= 0;
            end    
        elseif ((angle >22.5 && angle < 67.5)  || ( angle>202.5 && angle <247.5))
            %Non max supression in diagonal direction 45 degrees
           if(Ixy(i-1,j-1)>Ixy(i,j) && Ixy(i+1,j+1)>Ixy(i,j))
                 Ixy(i,j)= 0;
           end     
        elseif ((angle > 67.5 && angle < 112.5) || (angle >247.5 && angle <292.5))  
           %Non max supression in vertical direction -90 degrees
            if(Ixy(i,j-1)>Ixy(i,j) && Ixy(i,j+1)>Ixy(i,j))
                Ixy(i,j)= 0;
            end
       elseif((angle > 112.5 && angle < 157.5) || (angle >292.5 && angle <337.5))
             %Non max supression in anti diagonal direction - 135 degrees
             if(Ixy(i+1,j+1)>Ixy(i,j) && Ixy(i-1,j-1)>Ixy(i,j))
                 Ixy(i,j)= 0;
             end 
       end     
     end
  end
 end      
           
  
  
  
  