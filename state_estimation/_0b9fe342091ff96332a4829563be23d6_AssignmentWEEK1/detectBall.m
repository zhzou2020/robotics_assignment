% Robotics: Estimation and Learning 
% WEEK 1
% 
% Complete this function following the instruction. 
function [segI, loc] = detectBall(I)
% function [segI, loc] = detectBall(I)
%
% INPUT
% I       120x160x3 numerial array 
%
% OUTPUT
% segI    120x160 numeric array
% loc     1x2 or 2x1 numeric array 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hard code your learned model parameters here
%
mu = [149.2171 143.9402 61.2023];
sig = [180.1341 133.2750 340.6981];
thre = 1e-07;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model
% 
p = zeros(120, 160);
for i = 1:120
    for j = 1:160
        p(i,j) = mvnpdf(double([I(i,j,1) I(i,j,2) I(i,j,3)]), mu, sig) > thre;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do more processing to segment out the right cluster of pixels.
% You may use the following functions.
%   bwconncomp
%   regionprops
% Please see example_bw.m if you need an example code.
segI = zeros(120, 160);

CC = bwconncomp(p);
numPixels = cellfun(@numel, CC.PixelIdxList);
[~, idx] = max(numPixels);
segI(CC.PixelIdxList{idx}) = true; 

S = regionprops(CC, 'Centroid');
loc = S(idx).Centroid; 

% Note: In this assigment, the center of the segmented ball area will be considered for grading. 
% (You don't need to consider the whole ball shape if the ball is occluded.)

end
