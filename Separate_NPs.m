#El objetivo de este script es separar las Nanopartículas
#Vamos a usar un proceso iterativo que parte de los pulsos iniciales y calcula el promedio y la desviación estándar d elos pulsos
#Después separa los pulsos que sean mayores que el promedio+3*desviación
#Con los que quedan repite el proceso hasta que no se separe ninguno
#El script necesita un parámetro: una matriz con todos los pulsos encontrados. 
#Esta matriz incluye tres datos por pulso: posición, valor, duración. Para separar los NPs sólo necesitamos el valor
# Notación: NP: nanopartículas; BG: background
function salida = Separate_NPs(pulsos)
#cargamos el paquete de estadísticas por si no está cargado
pkg load statistics;
#Inicialemnte todos los pulsos son BG
BG=pulsos;
promedio_pulsos=mean(BG(:,2));
standard_deviation=std(BG(:,2));
threshold =(promedio_pulsos + 3*standard_deviation);
seguir=1;
size= numel(pulsos,":",2);# nos da el número de elementos
#Creamos una matriz vacia en la que meteremos las NP
NP=zeros(size,3);
#BG_sig se usa para generar los BG de la isguiente iteración
BG_sig=zeros(size,3);
NP_count=0; #llevas la cuenta global de las NPs
while (seguir == 1)
	BG_count=0; #lleva la cuenta local de las BGs (local=a cada iteración del while)
	#este for separa a los pulsos en función del thresshold
	seguir=0;#si en el próximo for no hay NPs hemos terminado el while
	for i = 1:size
		dato = BG(i,2);
		if (dato > threshold)
			NP_count++;
			NP(NP_count,:)=BG(i,:);
			seguir=1; #mientras se encuentren NPs se sigue iterando
		else
			BG_count++;
			BG_sig(BG_count,:)=BG(i,:);
		end;
	endfor
	#se preparan los datos para la siguiente iteración
	BG_size = numel(BG_sig,":",2);# nos da el número de elementos que quedan en el BG
	size=BG_size;
	BG=zeros(BG_size,3);
	BG=BG_sig(1:BG_size,:);
	BG_sig=zeros(BG_size,3);
	promedio_pulsos=mean(BG(:,2));
	standard_deviation=std(BG(:,2));
	threshold =(promedio_pulsos + 3*standard_deviation);
endwhile;
	csvwrite('BGs.csv', BG);
	csvwrite('NPs.csv', NP);
salida=NP;
end;