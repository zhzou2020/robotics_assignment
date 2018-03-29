% Robotics: Estimation and Learning 
% WEEK 4
% 
% Complete this function following the instruction. 
function myPose = particleLocalization(ranges, scanAngles, map, param)

% Number of poses to calculate
N = size(ranges, 2);
% Output format is [x1 x2, ...; y1, y2, ...; z1, z2, ...]
myPose = zeros(3, N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Map Parameters 
% 
% the number of grids for 1 meter.
myResol = param.resol;
myOrigin = param.origin; 
myPose(:,1) = param.init_pose;

M = 1000; % the number of particles
R = 500; % the number of sampled measurements

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create M number of particles
P = repmat(myPose(:,1), [1, M]);
weights = ones(1, M) * 1.0;
sigma = [0.03 0 0;
         0 0.03 0;
         0 0 0.02];
     
for j = 2:N
    % Propagate the particles 
    P = P + mvnrnd(zeros(1,3), sigma, M)';
    
    % Measurement Update
    [angle_sample, idx] = datasample(scanAngles, R, 'Replace', false);
    angle_sample = angle_sample';
    range_sample = ranges(idx, j)';

    corr = zeros(1, M);
    for i = 1:M
        % 2 * R
        end_point = ceil(myResol * ([cos(P(3, i) + angle_sample); -sin(P(3, i) + angle_sample)] .* [range_sample; range_sample] + P(1:2, i))) + myOrigin;

        del_occ = end_point(1, :) < 1 | end_point(2, :) < 1 | end_point(1, :) > size(map,2) | end_point(2, :) > size(map,1);
        end_point(:, del_occ) = [];
        
        occ = sub2ind(size(map), end_point(2, :), end_point(1, :));
        corr(i) = sum(sum(map(occ)>=0.5)) * 10 - sum(sum(map(occ)<-0.5)) * 5;
    end

    % Weights update
    % corr = corr - min(corr);
    corr = corr .* corr;
    corr = corr / sum(corr);
    weights = weights .* corr;
    [~, ind] = max(weights);
    myPose(:, j) = P(:, ind);
     
    % Resample
    P = datasample(P, M, 2, 'Weights', weights);
    weights = ones(1, M) * 1.0;

end

end