clear; close all; clc;

IP = input('Enter the order of Governing Polynomial Equation...! \n');
N  = int64(IP);
Poly_Coeff = zeros(1,N);

for i = 1 : N
pmt_spec        = "Enter the first %d - coefficient of %d-th Order : \n";
temp            = sprintf(pmt_spec, i,N);
ip_temp         = input(temp);
Poly_Coeff(1,i) = ip_temp;
end

AA = [1 2 3 4 5 6];

[SS,ll] = Routh_Hurwitz_Stability_Criterion(Poly_Coeff)



