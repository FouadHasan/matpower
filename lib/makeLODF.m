function LODF = makeLODF(branch, PTDF);
%MAKELODF   Builds the line outage distribution factor matrix.
%   LODF = makeLODF(branch, PTDF) returns the DC line outage
%   distribution factor matrix for a given PTDF. The matrix is nbr x nbr,
%   where nbr is the number of branches.

%   MATPOWER
%   $Id$
%   by Ray Zimmerman, PSERC Cornell
%   Copyright (c) 2008 by Power System Engineering Research Center (PSERC)
%   See http://www.pserc.cornell.edu/matpower/ for more info.

[F_BUS, T_BUS, BR_R, BR_X, BR_B, RATE_A, RATE_B, RATE_C, ...
    TAP, SHIFT, BR_STATUS, PF, QF, PT, QT, MU_SF, MU_ST, ...
    ANGMIN, ANGMAX, MU_ANGMIN, MU_ANGMAX] = idx_brch;

[nl, nb] = size(PTDF);
f = branch(:, F_BUS);
t = branch(:, T_BUS);
Cft =  sparse([f; t], [1:nl 1:nl]', [ones(nl, 1); -ones(nl, 1)], nb, nl);

H = PTDF * Cft;
h = diag(H, 0);
LODF = H ./ (ones(nl, nl) - ones(nl, 1) * h');
LODF = LODF - diag(diag(LODF)) - eye(nl, nl);
