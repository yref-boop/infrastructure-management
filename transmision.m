%%%%%%           SISTEMA DE TRANSMISION BANDA BASE         %%%%%%


clear all;
close all;

%=================== Parámetros ==================================
N=10;		 % Periodo de símbolo
L=10;		 % Número de bits a transmitir
tipopulso=1; 	 %1: pulso rectangular



%=================== Generacion del pulso =========================

if tipopulso == 1  %pulso rectangular
  n=0:N-1;
  pulso=ones(1,N);
elseif tipopulso == 2 %escriba un elseif por cada tipo
end;


%=================== Calculo de la energia del pulso =============
%Escriba el codigo para calcular la energia

%=================== Generacion de la senal (modulacion) =========

bits=rand(1,L) < 0.5; %genera 0 y 1 a partir de un vector de numeros
                      %aleatorios con distribucion uniforme

%Escriba un bucle que asocie un pulso con amplitud positiva a un bit 0 y
%un pulso con amplitud negativa a un bit 1


%=================== Generación de señal recibida  =============
%Escriba el codigo para obtener la señal recibida (transmitida + ruido)

%=================== Calculo de la proabilidad de error ===========
%Escriba el codigo para calcular la probabilidad de error teórica y rea


%=================== Representacion grafica ===================
figure(1)
plot(n,pulso);
axis([0 N -2 2])
xlabel('t(s)')
ylabel('Valor')
title('Pulso transmitido: p(n)');
grid;

figure(2)
stem(n,pulso);
axis([0 N -2 2])
xlabel('t(s)')
ylabel('Valor')
title('Pulso transmitido: p(n)');
grid;

figure(3)
subplot(211)
%Escriba el codigo para representar la senal transmitida sin ruido
%utilize title, axis, xlabel e ylabel para ajustarla e identificarla correctamente

subplot(212)
%Escriba el codigo para representar la senal recibida
%utilize title, axis, xlabel e ylabel para ajustarla e identificarla correctamente


