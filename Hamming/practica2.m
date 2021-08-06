%% Práctica 2: Red de Hamming
clear all; close all; clc
%rasgos=4; clases=3;
%rasgos=6; clases=5;
rasgos=8; clases=8;

% Para abrir el archivo de los pesos w1.txt
w1=fopen('w1.txt','r');
formatSpec = '%d %d';
W1 = fscanf(w1,formatSpec, [rasgos clases]);
W1=W1';
fclose(w1);

% Para abrir el archivo del vector de entrada p_new.txt
p_new = fopen('p_new.txt','r');
formatSpec = '%d %d';
P = fscanf(p_new,formatSpec, [rasgos, 1]);
fclose(p_new);

% Obtener el valor de épsilon
[S, R]=size(W1);
eps=1/(S-1);
eps=eps*(rand());

% Para generar el bias
for i=1:S
    b1(i,1)=R;
end

% CAPA FEEDFORWARD
a1=(W1*P)+b1;
a2=a1;
valores = fopen('a2.txt','w');
fprintf(valores,'%4.2f  ',a1);

% Para la generación de la matriz de pesos W2
for i=1:S
    for u=1:S
        if i==u
            W2(i,u)=1;
        else
            W2(i,u)=-1*eps;
        end
    end
end

max_it=uint8(100+rand()*200);
msg=['El valor de épsilon a utilizar es: ', num2str(eps)];
disp(msg)
msg=['El número máximo de iteraciones a realizar es: ',num2str(max_it)];
disp(msg)

% CAPA RECURRENTE
conv = 0;
for ii=1:max_it
    a2=W2*a2;
    a2=poslin(a2);
    sum=0;
    for u=1:S
        if a2(u)~= 0
            sum=sum+1;
        end
    end
    if sum==1
        conv=conv+1;
    end
    fprintf(valores,'\n');
    fprintf(valores,'%4.2f  ',a2);
    if  conv==2
        break
    end
end

% Para hacer el vector de iteraciones (tiempo)
fclose(valores);
for u=1:ii+1
    t(u)=u-1;
end

% Para mostrar la gráfica obtenida
rv = fopen('a2.txt','r');
formatSpec = '%f %f';
sizeA = [S inf];
A = fscanf(rv,formatSpec,sizeA);
A=A';
[x, y]=size(A);

for i=1:y
    msg=['Clase ',num2str(i)];
    plot(t,A(:,i),'o-', 'DisplayName',msg);
    lgd = legend;
    hold on;
end
hold off;
title('Red de Hamming')
xlabel('Tiempo')
ylabel('Valores de a2')

if conv== 2
    disp('LA RED CONVERGIÓ');
    msg=['Se hicieron ', num2str(ii),' iteraciones'];
    disp (msg);
    [y ,class]=max(a2);
    msg=['El vector de entrada pertenece a la clase: ', num2str(class)];
    disp(msg);
else
    disp('LA RED NO CONVERGIÓ');
end
fclose(valores);