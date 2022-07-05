function [P,X,Y,L] = Fibbo_gen(N)
P = [0 0];
X = [0];
Y = [0];
L =0 ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Fibbonacci Numbers %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = [0 1];
for i = 1:N
    temp = F(end) + F(end-1);
    F    = [F temp];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Centroid Finder %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = [0 0; 0 0; 0 0];
for j = 3 : N
    pivot = rem(j-3, 4);
    if pivot == 1
         X_flag    = 1;
         Sign_Flag = 1; 
    elseif pivot == 2
        X_flag    = 0;
        Sign_Flag = 1;
    elseif pivot == 3
        X_flag    = 1;
        Sign_Flag = 0;
    elseif pivot == 0
        X_flag    = 0;
        Sign_Flag = 0;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x_temp = I(j,1);
    y_temp = I(j,2);
    if Sign_Flag == 1 && X_flag == 1
        x_temp = x_temp +  F(j-2);
    elseif Sign_Flag == 1 && X_flag == 0
        y_temp = y_temp +  F(j-2);
    elseif Sign_Flag == 0 && X_flag == 1
        x_temp = x_temp -  F(j-2);
    elseif Sign_Flag == 0 && X_flag == 0 
        y_temp = y_temp -  F(j-2);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I       = [I; x_temp y_temp];
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Curve Formation %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F       = F(2:end);
C       = I(3:end,:);
Angle   = [271 360; 1 90; 91 180; 181 270; ];

for k = 1 : size(C,1)
    pivot_a = rem(k,4);
    AnR     = Angle(pivot_a+1,:);
    r       = F(k);
    
    %%%% x,y alignment %%%%%
    x_align = C(k,1);
    y_align = C(k,2);
    for k1 = AnR(1):AnR(2)
        x_temp =  r*cos(deg2rad(k1));
        y_temp =  r*sin(deg2rad(k1));
        P      = [P ; x_temp+x_align y_temp+y_align];
        X      = [X  x_temp+x_align];
        Y      = [Y  y_temp+y_align];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Length Finder %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = 0;
for l1 = 1 : size(F,2)
    r_temp = F(l1);
    L = L + (pi*r_temp/2);
end







