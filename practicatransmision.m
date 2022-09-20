%%%%%%           SISTEMA DE TRANSMISION BANDA BASE         %%%%%%

clear all;
close all;

%=================== parametros ==================================

N=10;               % periodo de simbolo
L=10;               % numero de bits a transmitir
tipopulso=1;        % 1: pulso dado
        

%=================== generacion del pulso =========================

n = 0 : N-1;        % n size
pulso = zeros(1,N); % default pulse to 0

if tipopulso == 1       % N rectangular
    pulso (:) = 1;
elseif tipopulso == 2   % N/2 +1 pulse
    pulso (1:N/2) = 1;
elseif tipopulso == 3   % N/2 +-1 pulse
    pulso (1:N/2) = 1;
    pulso (N/2 +1:end) = -1;
elseif tipopulso == 4   % escala
    pulso = linspace(0, 1, N);
end;


%=================== calculo de la energia del pulso =============
% escriba el codigo para calcular la energia del pulso

Ep = sum(abs(pulso).^2);

%=================== generacion de la senal (modulacion) =========

bits=rand(1,L) < 0.5; % genera 0 y 1 a partir de un vector de numeros 
                      % aleatorios con distribucion uniforme

% escriba un bucle que asocie un pulso con amplitud positiva a 0 y 
% un pulso con amplitud negativa a 1

%=================== representacion grafica ===================
figure(1)
plot(n,pulso);
title('Pulso transmitido: p(n)');
grid;
 
figure(2)
% escriba el codigo para representar la senal 
