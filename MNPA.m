%Robert Chitiu
%101047295

R1=1;
R2=2;
R3=10;
R4=0.1;
Ro=1000;
a=100;
L=0.2;
Cap=0.25;

G = zeros(8,8);
C = zeros(8,8);
F = zeros(8,1);

Vin = linspace(-10,10,100);
Vo = zeros(100,1);
V3 = zeros(100,1);
Av = zeros(100,1);
w = 2*pi*linspace(0,80,100);


G(1,1) = 1/R1;
G(1,2) = -1/R1;
G(2,1) = -1/R1;
G(2,2) = -1/R1+1/R2;
G(3,3) = 1/R3;
G(4,4) = 1/R4;
G(5,4) = 1/R4;
G(4,5) = -1/R4;
G(5,5) = 1/R4+1/Ro;
G(6,2) = -1;
G(6,1) = 1;
G(7, 2) = 1;
G(7, 3) = -1;
G(8, 3) = -a/R3;
G(8, 4) = 1;
G(1, 6) = 1;
G(2, 7) = 1;
G(3, 7) = -1;
G(4, 8) = 1;

C(2,1) = Cap;
C(2,2) = -Cap;
C(6,6) = L;



for i=1:100
   F(6) = Vin(i);
   V = G\F;
   Vo(i) = V(5);
   V3(i) = V(3);
end

figure (1)
plot(Vin,Vo)
hold on
plot(Vin,V3)

Vo = zeros(100,1);
for i=1:100
    s=1i*w(i);
    A = G + (s.*C);
    V = A\F;
    Vo(i) = abs(V(5));
    Av(i) = 20 * log(abs(Vo(i))/abs(V(1)));
end

figure (2)
plot (w,Vo)
figure (3)
plot(log(w),Av)

 p = 0.05*randn(1,100);
 Vo = zeros(100,1);
 s = 2*pi;
for i=1:100
    C(1,1) = 0.25*p(i);
    C(1,2) = -0.25*p(i);
    C(2,1) = -0.25*p(i);
    C(2,2) = 0.25*p(i);
 
    A = G +(s.*C);
    V = A\F;
    Vo(i) = abs(V(5));
    Av(i) = 20*log(abs(Vo(i))/abs(V(1)));
end

figure(4)
histogram(Av,100)





