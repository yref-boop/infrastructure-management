%% TRANSMISIÓN BANDA BASE

clear all;
close all;

% parámetros
N=10;     % periodo do símbolo
L=10;     % bits a mandar
EbNodB=20;  % calidade (enerxia bit / ruido (dB)
tipo = 'serra';
% rectangular
% cadrada
% manchester
% serra

% creación do pulso
n=0:N-1;
pulso = zeros (1, N);
if strcmp (tipo, 'rectangular')
    pulso (:) = 1;
elseif strcmp (tipo, 'cadrada')
    pulso (1 : N/2) = 1;
    pulso (N/2 + 1 : end) = 0;
elseif strcmp (tipo, 'manchester')
    pulso (1 :N/2) = 1;
    pulso (N/2 + 1 : end) = -1;
elseif strcmp (tipo, 'serra')
    pulso = linspace (0, 1, N);
end;

% cálculo da enerxía
Ep = sum(pulso.^2);
Eb = Ep;

% ruido
EbNo=10^(EbNodB/10);
ruido=sqrt((Eb/EbNo)/2)*randn(1,N*L);

% modulación
bits = rand(1, L) < 0.5;
% lazo que faga a seguinte asociación:
%   A > 0 -> bit = 0
%   A < 0 -> bit = 1
sinal_modular=[];
for i=1 : L
  A = 1-2*bits(i);
  sinal_modular = [sinal_modular, pulso*A];
end
sinal_recibida = sinal_modular + ruido;

% creación da señal recibida
% señal recibida (transmitida + ruido)

% probabilidade de erro
% probabilidades teórica e real

% representación gráfica
%TODO: separar e parametrizar
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

