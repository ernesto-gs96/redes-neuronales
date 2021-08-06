clear all;
clc
display ('Célula de McCulloch-Pitts')
display ('1) NOT')
display ('2) AND')
display ('3) OR')
tipoCompuerta=input('Esriba el número de la compuerta que la célula aprenderá: ');
if tipoCompuerta==1
    n=1;
    tt=tabla_de_verdad(tipoCompuerta,n);
elseif tipoCompuerta==2 || tipoCompuerta==3
    n=input('Escriba el numero de bits de entrada (>=2): ');
    tt=tabla_de_verdad(tipoCompuerta,n);
end
n_epoch=input('Escriba el numero épocas que desea realizar (>=50): ');
epoch=1;
correct=0;
tot=2^n;
while correct==0
    while epoch<=n_epoch
            ww=round(rand(n,1)*20-10);
            umbral=round(rand(1,1)*20-10);
        
        for x=1:tot
            sum=0;
            for y=1:n
                sum=sum+tt(x,y)*ww(y);
            end
            
            if sum>umbral
                result=1;
            else
                result=0;
            end
            
            if result==tt(x,n+1)
                correct=1;
            else
                correct=0;
                break;
            end
        end
       
        if correct==1
            display ('APRENDIZAJE EXITOSO EN LA ÉPOCA:')
            display(num2str(epoch));
            epoch=epoch+50;
            display( 'El valor del umbral es: ');
            display(num2str(umbral));
            display ('Los pesos sinápticos son: ');
            for i=1:n
                display(num2str(ww(i)));
            end
            name=num2str(tipoCompuerta);
            name=['val_finales_correctos_',name,'.txt'];
            fileID = fopen(name,'w');
            fprintf(fileID,'El valor del peso es : %4.2f \n',ww);
            fprintf(fileID,'El valor del umbral es : %4.2f',umbral);
            fclose(fileID);
        end
        epoch=epoch+1;
    end

    if correct==0
        display ('Los pesos y umbrales evaluados NO funcionan para que la celula tenga el comportamiento de la compuerta seleccionada')
        epoch=input('Quiere realizar otra intento (1-si/0-no) ? : ');
        if epoch==0
            name=num2str(tipoCompuerta);
            name=['val_finales_incorrectos_',name,'.txt'];
            fileID = fopen(name,'w');
            fprintf(fileID,'El valor del peso es : %4.2f \n',ww);
            fprintf(fileID,'El valor del umbral es : %4.2f',umbral);
            fclose(fileID);
            correct=1;
        end
    end
end