function [u,v] = LK(image1, image2)
% Lucas-Kanade: Optical Flow
   [I_x, I_y, I_t] = find_deriv(image1, image2);
   u = zeros(size(image1));
   v = zeros(size(image2));
   window = 5;
   half_win = floor(window/2);
   for i = 1+half_win:size(I_x, 1)-half_win
       for j = 1+half_win:size(I_x, 2)-half_win
           I_x_win = I_x(i-half_win:i+half_win, j-half_win:j+half_win);
           I_y_win = I_y(i-half_win:i+half_win, j-half_win:j+half_win);
           I_t_win = I_t(i-half_win:i+half_win, j-half_win:j+half_win);
           A = [I_x_win(:) I_y_win(:)];  % Unpacks the matrix into columns
           b = I_t_win(:);
           w = pinv(A)*b;
           u(i,j) = w(1);
           v(i,j) = w(2);
       end
   end
end