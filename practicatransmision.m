%%%%%%           SISTEMA DE TRANSMISION BANDA BASE         %%%%%%

clear all;
close all;

%======================= functions ==============================%

function diagramaojo(senal,N,L)
% representacion del diagrama de ojo

figure;
hold on;
S=(2*N);
T=floor(L/2)+mod(L,2)-1;
for i=1:T
  dib=senal(1,(((2*N)*(i-1))+1):((2*N*i)+1));
  ejex2=0:S;
  plot(ejex2,dib);
endfor
end

function [H,W]=dtft(h,N)

%DTFT	calculate DTFT at N equally spaced frequencies
%	usage: [H,W]=dtft(h,N);
%	h: finite-length input vector, whose length is L
%	N: number of frequencies for evaluation over [-pi,pi]
%		==> constraint: N>=L
%
%	H: DTFT values (complex)
%	W: vector of freqs where DTFT is computed
%
N=fix(N);
L=length(h);
h=h(:);		%<-- for vectors ONLY %
if (N<L)
	error('DTFT: # data samples cannot exceed # freq samples')
end
W=(2*pi/N) * [0:(N-1)]';
mid=ceil(N/2)+1;
W(mid:N)=W(mid:N)-2*pi;		%<-- move [pi,2pi] to [-pi,0]
W=fftshift(W);
H=fftshift(fft(h,N));		%<-- move negative freq components

end

%=================== parametros ==================================

N=10;               % periodo de simbolo
L=5;                % numero de bits a transmitir
tipopulso=3;        % 1: pulso dado
EbNo=100 ;          % EbNo en dB
W=pi/8;             % Ancho de banda del canal

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
elseif tipopulso == 5
    pulso = n/(N-1);
end;

%=================== calculo de la energia del pulso =============

Ep = sum(abs(pulso).^2);

%=================== generacion de ruido ==========================

%cambio a unidades naturales y calculo de No
Eb = Ep;

EbNo=10^(EbNo/10);
No=Eb/EbNo;
ruido=sqrt(No/2)*randn(1,N*L);

%========== generacion del canal de banda limitada ==============%

NL2=fix(N*L/2);
n2=-NL2:NL2-1;
h=sin(W*n2)./(pi*n2);
pos=find(n2==0);
h(pos)=W/pi;
if (pi/N)>W
  h=h*pi/W/N;
end;

%=================== generacion de la senal (modulacion) =========

bits=rand(1,L) < 0.5; % genera 0 y 1 a partir de un vector de numeros
                      % aleatorios con distribucion uniforme

% escriba un bucle que asocie un pulso con amplitud positiva a 0 y
% un pulso con amplitud negativa a 1
s_mod = [];
for k = 1:L
    Ak = 1 - 2*bits(k);
    s_mod = [s_mod,pulso*Ak];
end

s_rec=conv(s_mod,h);
s_rec=s_rec(NL2+1:length(s_rec)-NL2+1);
ruido=sqrt(No/2)*rand(1,N*L);
s_rec=s_rec+ruido;


%=================== representacion grafica ===================

figure(1)
plot(n,pulso);
title('pulso transmitido: p(n)');
grid;

%escriba el codigo para representar la senal
figure;
plot(0:N*L-1,s_mod);
hold on;
plot(0:N*L-1,s_rec,'r');
axis([0 N*L-1 -2 2]);
title('Senal modulada y recibida')

diagramaojo(s_rec,N,L)


%calcular y representar la transformada de Fourier del pulso y canal

[H,Wrad]=dtft(h,(2*L*N)+50);
[P,Wrad]=dtft(pulso,(2*L*N)+50);
figure;
plot(Wrad,abs(P)/max(abs(P)));
grid;
hold on;
plot(Wrad,abs(H)/max(abs(H)),'r');
title('respuesta en frecuencia del canal H(W) y T.F. del pulso P(W)');

waitfor(gcf)
