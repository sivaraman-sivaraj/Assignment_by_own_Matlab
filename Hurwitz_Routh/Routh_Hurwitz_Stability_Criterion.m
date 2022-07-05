function [A,S_C] = Routh_Hurwitz_Stability_Criterion(Poly_Coeff)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This function takes polynomial co-efficients of Equation and retuns the
%%% type of stability system has..! 1. Stable 2.Unstable 3. marginally
%%% stable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_C      = 'The system is Unstable';
episilon = 0.01;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Calculations Start %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if all(Poly_Coeff) < 0 || all(Poly_Coeff) > 0
    Row_0 = Poly_Coeff(:,1:2:end);
    Row_1 = Poly_Coeff(:,2:2:end);
    if length(Row_1) < length(Row_0)
        Row_1  = [Row_1 0];
    end
    A     = [Row_0; Row_1];
    O_idx = 2; % To calculate the position of zero row vector happening...!
    for j = 1 : length(Poly_Coeff)-2 % Total number of iteration
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        A_temp = zeros(1,length(Row_1));
        for i = 2 : length(Row_0)
            temp           = ((A(end,1)*A(end-1,i)) - (A(end-1,1)*A(end,i)))/A(end,1);
            A_temp(1,i-1)  = temp;
        end
        %%%%%% Special case 1 check %%%%%%%
        if A_temp(1) == 0
            idx_temp   = find(A_temp == 0);
            A_temp(1)  = episilon;
            %%%%% Special Case 2 check %%%%%%%
            if length(Row_0) == length(idx_temp)
            spc2_M1 = flip(0:2:length(Poly_Coeff)-O_idx) - 1;
            A_temp  = spc2_M1.*A(end,:);
            end
        end
        O_idx = O_idx + 1;
        A = [A; A_temp];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Calculations End %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Unit_Matrix0 = ones(length(Poly_Coeff),1);
Unit_Matrix1 = ones(length(Poly_Coeff),1)*(-1);
Pivot0       = sign(A(:,1)) == Unit_Matrix0;
if sum(Pivot0) == length(Pivot0)
    S_C  = 'The system is Stable';
end 
Pivot1       = sing(A(:,1)) == Unit_Matrix1;
if sum(Pivot1) == (-1)*length(Pivot1)
    S_C  = 'The system is Stable';
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end