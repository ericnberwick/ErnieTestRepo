function p = approxeq1(a, b, tol)
% APPROXEQ Are a and b approximately equal (to within a specified tolerance)?
% p = approxeq(a, b, thresh)
% 'tol' defaults to 1e-3.
% p(i) = 1 iff abs(a(i) - b(i)) < thresh

if nargin<3, tol = 1e-3; end

p = (all(all(abs(a(:, :)-b(:, :)) <= tol)));
%p = (abs(a(:)-b(:)) < tol);
