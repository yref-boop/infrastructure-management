%% TRANSMISIÓN BANDA BASE

clear all;
close all;

% parámetros
N=10;   % periodo do símbolo
L=10;   % bits a mandar
tipopulso=1;

% creación do pulso
if tipopulso == 1
  n=0:N-1;
  pulso=ones(1,N);
elseif tipopulso == 2
end;

% cálculo da enerxía

% modulación
bits=rand(1,L) < 0.5;
% lazo que faga a seguinte asociación:
%   A > 0 -> bit = 0
%   A < 0 -> bit = 1

% creación da señal recibida
% señal recibida (transmitida + ruido)

% probabilidade de erro
% probabilidades teórica e real

% representación gráfica
figure(1)
plot(n,pulso);
axis([0 N -2 2])
xlabel('t(s)')
ylabel('valor')
title('pulso transmitido: p(n)');
grid;

figure(2)
stem(n,pulso);
axis([0 N -2 2])
xlabel('t(s)')
ylabel('valor')
title('pulso transmitido: p(n)');
grid;

figure(3)
subplot(211)
% representar o sinal transmitido sen ruído (con title, axis, xlabel e ylabel)

subplot(212)
% representar o sinal recibido (con title, axis, xlabel e ylabel)

waitfor(gcf)

