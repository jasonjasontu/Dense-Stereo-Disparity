% Need two images in the folder in order to run this program. 
im0=imread('im0.png');
im1=imread('im1.png');

Nt = 5;
N = 1/Nt;
patch_size = 7;

width = round(patch_size/2);
max_disparity = round(270*N);

% Single Channel Downsize 
im0 = singleChannel(im0, width, N);
im1 = singleChannel(im1, width, N);
% Get the size of the image after resizing
[Y, X] = size(im0);

%display the total size
disp(Y);
disp(X);

%initialize an matrix for output
disparity = zeros(Y-2*width,X-2*width);

%loop through each row
for r = 1+width : Y-width
    for c = 1+width : X-width

        %gettting a patch
        patch = im0(r-width:r+width,c-width:c+width);

        %compute the match 
        match = normxcorr2(patch, im1(r-width:r+width,:));

        %get the most matching point
        [ypeak, xpeak] = find(match==max(match(:)));

        %calculate disparity for that point
        temp = round(c - xpeak(1) + width);

        %check whether it is in the range
        if (temp >= 0) & (temp <= max_disparity)
            disparity(r-width,c-width) = temp*Nt;
        else
            disparity(r-width,c-width) = -1;
        end
    end
    disp(r); %just for check the progress of the program 
end

%save and display the output
save disparity.mat disparity;
imagesc(disparity);
