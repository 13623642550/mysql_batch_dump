@echo off

:begin

set /p dir_path=������mysql���ڴ���·����:e���������ǰ���̼�Ϊ���ڴ��̣���ֱ�ӻس�����
%dir_path%:

set /p mysql_bin_path=������mysql binĿ¼ȫ·�����磺E:\MySQL\bin����
cd %mysql_bin_path%

set /p username=���������ݿ��û�����
echo %username%

set /p password=���������ݿ����룺
echo %password%
rem ��������˻س�����������Ϊ���ַ���
if "%password%"=="" set password= 
echo �����˻س���������Ϊ���ַ���=%password% 

set /p db_name=���������ݿ�����
echo %db_name%

set /p table_name=�����������
echo %table_name%

set /p total_number=�������ܵ�����������
echo ������=%total_number%

set /p data_number=�����뵥���ļ���Ҫ������������
echo ÿҳ��ʾ����=%data_number%

set /a page_number=%total_number%/%data_number%+1
echo ����Ϊ%page_number%ҳ

set /p start_page=��������ʼҳ����0Ϊ��һҳ��1Ϊ�ڶ�ҳ���Դ����ƣ���
echo ��ʼҳ��=%start_page%

set /a var=%start_page%
set /a stop=%page_number%-1
echo ֹͣ��������=%stop%

echo ��ʼ�������ݽű�

rem ѭ�������ļ�
:loop_export

set /a offset=%var%*%data_number%
echo ��ʼ����=%offset%��ÿҳ����=%data_number%

mysqldump -u%username% -p%password% -t %db_name% %table_name% --where="1=1 limit %offset%,%data_number%" > e:\gaoxiaobao\datas\%table_name%%var%.sql
echo ��ɵ����ļ�e:\gaoxiaobao\datas\%table_name%%var%.sql

rem ����ļ�������ϣ��������ɵķ�����finish���������������ѭ��������loop_export��
if %var%==%stop% goto finish
set /a var+=1
goto loop_export

:finish
echo �������!!!
pause
