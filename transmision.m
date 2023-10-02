
clear all;
close all;

%===================  parámetros  ==================================

periodo = 10;           % periodo de simbolo
longitud = 1000;          % bits a transmitir
calidad = 10;           % energia bit / ruido (dB)

tipo = 'rectangular';

%rectangular%
%cuadrada%
%sierra%

%=================== generación del pulso =========================

desplazamiento = 0 : periodo - 1;
pulso = zeros (1, periodo);


if strcmp (tipo, 'rectangular')
    pulso (:) = 1;

elseif strcmp (tipo, 'cuadrada')
    pulso (1 : periodo/2) = 1;
    pulso (periodo/2 + 1 : end) = -1;

elseif strcmp (tipo, 'sierra')
    pulso = linspace (0, 1, periodo);
end;


%=================== energía del pulso ===========================

energia_pulso = sum (abs (pulso).^2);
energia_bit = energia_pulso;    %para 2PAM


%=================== ruido =======================================

calidad = 10^(calidad/10); %cambio a unidades naturales
ruido = sqrt((energia_bit/calidad)/2) * randn (1, periodo*longitud);


%=================== Generacion de la señal (modulacion) =========

bits = rand (1, longitud) < 0.5;    % random bits

% 0 -> amplitud positiva
% 1 -> amplitud negativa

modular_signal = [];
for i = 1:longitud
    amplitud = 1 - 2 * bits(i);
    modular_signal = [modular_signal, pulso*amplitud];
end

received_signal = modular_signal + ruido;


%=================== filtro adaptado ==========================

pulso_invertido = pulso (periodo:-1:1);

posicion = 1;
for k = 1:periodo:longitud*periodo-1
    convoluted_signal = conv (received_signal (k:k+periodo-1),pulso_invertido);
    sample_signal = convoluted_signal(periodo);
    bits_recibidos(posicion) = sample_signal <= 0;
    posicion = posicion + 1;
end;

prob_error_real = mean (bits_recibidos ~= bits)
prob_error_teorica = erfc (sqrt(calidad))/2     %2PAM

%=================== Representacion grafica ===================

figure(1)
plot (desplazamiento, pulso);
title('pulso transmitido: p(n)');
grid;

figure(2)
plot (desplazamiento : periodo*longitud-1, modular_signal);
hold on;
plot (desplazamiento : periodo*longitud-1, received_signal, 'r');
title ('señal modulada')

waitfor(gcf)
