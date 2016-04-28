function [I_x, I_y, I_t] = find_deriv(image1, image2)
    I_x = conv2(double(image1), 0.25*[-1 1; -1 1]) + conv2(double(image2), 0.25*[-1 1; -1 1]);
    I_y = conv2(double(image1), 0.25*[-1 -1; 1 1]) + conv2(double(image2), 0.25*[-1 -1; 1 1]);
    I_t = conv2(double(image1), 0.25*ones(2)) + conv2(double(image1), -0.25*ones(2));
end