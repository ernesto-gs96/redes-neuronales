%Seleccion de número de clases
RangoI = -3;
RangoF = 3;
punto = [1;1]; %punto de prueba una vez terminado el entranamiento
clases = input('Número de clases: ');

%Asignación de valores para el entranamiento
switch clases
    case 2
        disp('Perceptrón de 2 clases')
        BiasI = B0_2;
        PesoI = W0_2;
        Datos = Val_2(:,1:end-1);
        Targets = Val_2(:,end);
    case 4
        disp('Perceptrón de 4 clases')
        BiasI = B0_4;
        PesoI = W0_4;
        Datos = Val_4(:,1:end-2);
        Targets = Val_4(:,end-1:end);
    case 6
        disp('Perceptrón de 6 clases')
        BiasI = B0_6;
        PesoI = W0_6;
        Datos = Val_6(:,1:end-3);
        Targets = Val_6(:,end-2:end);
    otherwise
        disp('Opción no valida')
end

%Primera iteración, se le asignan los valores iniciales
BiasN = BiasI;
PesoN = PesoI;

i = 1; % i sera el número del punto
n = 0; % n sera el número de veces que el error sea 0
j = 1; % j sera el contador de iteraciones


%Proceso
while n ~= length(Datos) %n tendra que ser igual al número de puntos a probar
    
    %disp('Procesando...')
    A = hardlim(PesoN*Datos(i,1:end)' + BiasN);
    
    %Calculamos el error
    e = Targets(i,1:end)' - A;
    if e == 0 
        n = n + 1;
    else
        %Aplicación de reglas de aprendizaje e!=target
        BiasN = BiasN + e;
        PesoN = PesoN + e*Datos(i,1:end);
        n = 0;
    end
    
    %Reniciar contador del número de puntos
    if  i == length(Targets)
        i = 1;
    else
       i = i + 1; 
    end
    
    j = j +1;
end

%Peso y Bias obtenidos
disp('Peso:')
disp(PesoN)
disp('Bias:')
disp(BiasN)

%Grafica de puntos y frontera de decisión
figure
hold on
for n = 1:1:length(Datos)
    plot(Datos(n,1),Datos(n,2),'o')
end
%Frontera de decisión
for n = 1:1:clases/2
    if  PesoN(n,2) ~= 0
        x = (RangoI:0.1:RangoF);
        y = (-PesoN(n,1)*x-BiasN(n,1))/PesoN(n,2);
        plot(x,y);
    else
        y = (RangoI:0.1:RangoF);
        c = ones(1,length(y)); % c se utiliza para crear un arreglo similar a "y" sin afectar a "x"
        x = (-BiasN(n,1)/PesoN(n,1))*c;
        plot(x,y);
    end
end

%plotpc(PesoN,BiasN)

%Evaluación de un punto
disp('Evaluacion de un punto de prueba')
disp(punto)
A = hardlim(PesoN*punto + BiasN);
disp('Target de punto evaluado')
disp(A)

hold off








