t=0:2*pi/2^12:2*pi
y=0.5*sin(t)+0.5;
r=ceil(y*(2^8-1)); %��С��ת��Ϊ������ceil������ȡ����
fid = fopen('sin.coe','w'); %д��sin.coe�ļ���������ʼ��sin_rom
fprintf(fid,'MEMORY_INITIALIZATION_RADIX=10;\n');
fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n');
for i = 1:1:2^12
fprintf(fid,'%d',r(i));
if i==2^12
fprintf(fid,';');
else
fprintf(fid,',');
end
if i%15==0
fprintf(fid,'\n');
end
end
fclose(fid);
t=1:1:2^12;
y=(t<=2047);
r=ceil(y*(2^8-1));
fid = fopen('square.coe','w'); %д��square.coe��������ʼ��rom_square
fprintf(fid,'MEMORY_INITIALIZATION_RADIX=10;\n');
fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n');
for i = 1:1:2^12
fprintf(fid,'%d',r(i));
if i==2^12
fprintf(fid,';');
else
fprintf(fid,',');
end
if i%15==0
fprintf(fid,'\n');
end
end
fclose(fid);
t=1:1:2^12;
y=[0.5:0.5/1024:1-0.5/1024, 1-0.5/1024:-0.5/1024:0, 0.5/1024:0.5/1024:0.5];
r=ceil(y*(2^8-1));
fid = fopen('triangular.coe','w'); %д��triangular.coe����ʼ�����ǲ�rom
fprintf(fid,'MEMORY_INITIALIZATION_RADIX=10;\n');
fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n');
for i = 1:1:2^12
fprintf(fid,'%d',r(i));
if i==2^12
fprintf(fid,';');
else
fprintf(fid,',');
end
if i%15==0
fprintf(fid,'\n');
end
end
fclose(fid);