% Robotics: Estimation and Learning 
% WEEK 3
% 
% Complete this function following the instruction. 
function myMap = occGridMapping(ranges, scanAngles, pose, param)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Parameters 
% 
% % the number of grids for 1 meter.
myResol = param.resol;
myMap = zeros(param.size);
myorigin = param.origin; 
 
lo_occ = param.lo_occ;
lo_free = param.lo_free; 
lo_max = param.lo_max;
lo_min = param.lo_min;

M = size(scanAngles, 1);

N = size(pose, 2);
for j = 1:N
    start_point = ceil(myResol * pose(1:2, j)) + myorigin;
    for i = 1:M
        % Find grids hit by the rays (in the gird map coordinate)
        end_point = ceil(myResol * ([cos(pose(3, j) + scanAngles(i)); -sin(pose(3, j) + scanAngles(i))] * ranges(i, j) + pose(1:2, j))) + myorigin;
        [freex, freey] = bresenham(start_point(1), start_point(2), end_point(1), end_point(2));

        occ = sub2ind(size(myMap), end_point(2), end_point(1));
        free = sub2ind(size(myMap), freey, freex);
        
        % Update the log-odds
        myMap(free) = max(myMap(free) - lo_free, lo_min);
        myMap(occ) = min(myMap(occ) + lo_occ, lo_max);
    end 
end

end

