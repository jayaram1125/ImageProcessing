function [result] = HarrisCornerDetection(Ix, Iy, threshold,gker)
 
     Ix2 = Ix.*Ix;
     Iy2 = Iy.*Iy;
     Ixy = Ix.*Iy;
     
     Sx2 = GaussianFilter(Ix2,3,gker);
     Sy2 = GaussianFilter(Iy2,3,gker);
     Sxy = GaussianFilter(Ixy,3,gker);

     k =0.04;
     [row,col]=size(Ix);
     Hmat = zeros(2,2);
     result = zeros(row,col);
     
     for i = 1:row
         for j = 1:col
            Hmat(1,1) = Sx2(i,j);
            Hmat(1,2) = Sxy(i,j);
            Hmat(2,1) = Sxy(i,j);
            Hmat(2,2) = Sy2(i,j);
            traceval = (trace(Hmat)).^2;
            R = det(Hmat)-k*traceval;
            %Thresold on value of Response
            if(R > threshold)
                result(i,j) = R;
            end    
         end
     end
end     