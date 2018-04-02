function [ H ] = est_homography(video_pts, logo_pts)
% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 4x2 matrix of corner points in the video
%     logo_pts: a 4x2 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts ~ H*video_pts
% Written for the University of Pennsylvania's Robotics:Perception course

A = zeros(8, 9);
for i=1:4
    x1 = video_pts(i, 1);
    x2 = video_pts(i, 2);
    x1_l = logo_pts(i, 1);
    x2_l = logo_pts(i, 2);
    A(2*i, :) = [-x1 -x2 -1 0 0 0 x1*x1_l x2*x1_l x1_l];
    A(2*i+1, :)= [0 0 0 -x1 -x2 -1 x1*x2_l x2*x2_l x2_l];
end

[~, ~, V]= svd(A);
H = reshape(V(:, 9), [3, 3]).';

end