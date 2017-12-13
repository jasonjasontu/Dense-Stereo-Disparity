function [out] = singleChannel(in, width)
out = imresize(in, .05); 
out = out(:,:,2); 
out = padarray(out, [width width], 0, 'both');
end 
