function [TrajOut,TrajIn,TrajOutLow,TrajOutE] =  MotionDecomp(Traj,THRESH)
addpath ([pwd '\RASL_toolbox\']);

chunksz = size(Traj,2)/2;

Xs = Traj(:,1:chunksz)';
Ys = Traj(:,chunksz+1:end)';

perc = length( find((std(Xs) + std(Ys))<4) )/length(Xs);
X = zeros(2.*size(Xs,1),size(Xs,2));
for i=1:size(Xs,1);
    u1 = Xs(i,:);
    v1 = Ys(i,:);
    X(2*i-1:2*i,:) = [u1(:)'; v1(:)'];
end
FACTOR = .1;%.05;%.1%1;
lambda = FACTOR.*1.1/sqrt(size(X,1)) ;
tol = 1.0000e-006;
maxIter = 1000;
[A, E, numIter] = rasl_inner_ialm_noT(X, lambda, tol, maxIter);
EE = sum(E.^2);
outindS = find(EE > max(EE)./THRESH);% find(EE > max(EE)./650);
inindS = find(EE <= max(EE)./THRESH);% find(EE <= max(EE)./650);


[U,S,V] = svd(A);
S2 = 0.*S;
S2(1,1) = S(1,1);
S2(2,2) = S(2,2);
S2(3,3) = S(3,3);
%S2(4,4) = S(4,4);
A2 = U*S2*V';


XsoS = Xs(:,outindS);
YsoS = Ys(:,outindS);
XsiS = Xs(:,inindS);
YsiS = Ys(:,inindS);
if perc < .5 % moving camera
    XoLow = A(:,outindS);
    %XoE = E(:,outindS);
    
    XoE = E(:,outindS) + A(:,outindS) - A2(:,outindS);
    
    XsoSLow = XoLow(1:2:end,:);
    YsoSLow = XoLow(2:2:end,:);
    XsoSE = XoE(1:2:end,:) + repmat(XsoSLow(1,:),[size(XsoSLow,1) 1]) ;
    YsoSE = XoE(2:2:end,:) + repmat(YsoSLow(1,:),[size(YsoSLow,1) 1]) ;
else
    XoLow = X(:,outindS);
    XoE = XoLow;
    
    XsoSLow = XoLow(1:2:end,:);
    YsoSLow = XoLow(2:2:end,:);
    XsoSE = XsoSLow;
    YsoSE = YsoSLow;
end

% Final Result
TrajOut = [XsoS;YsoS]';
TrajIn = [XsiS;YsiS]';
TrajOutLow = [XsoSLow;YsoSLow]';
TrajOutE = [XsoSE;YsoSE]';