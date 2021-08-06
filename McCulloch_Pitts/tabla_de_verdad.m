function res=tabla_de_verdad(tipoCompuerta,n);
tot=2^n;
    b=n-1;
    for x=1:n
       t=2^b;
       c=0;
       for y=1:tot
           c=c+1;
           if c<=t 
               res(y,x)=1;
           else
               res(y,x)=0;
               if c==2*t
                    c=0;
               end
           end    
       end
       b=b-1;
    end
    if tipoCompuerta==1
       res(1,2)=0;
       res(2,2)=1;
    elseif tipoCompuerta==2
       for x=1:tot
           res(x,n+1)=res(x,1)&&res(x,2);
           if n>2 
                for y=3:n
                    res(x,n+1)=res(x,n+1)&&res(x,y);
                end
           end
       end
    elseif tipoCompuerta==3
        for x=1:tot
           res(x,n+1)=res(x,1)||res(x,2);
           if n>2 
                for y=3:n
                    res(x,n+1)=res(x,n+1)||res(x,y);
                end
           end
        end
    else
        display ('Por favor elija una compuerta válida.')
end