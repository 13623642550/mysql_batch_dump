@echo off

:begin
set /p dir_path=������mysql���ڴ���·����:e���������ǰ���̼�Ϊ���ڴ��̣���ֱ�ӻس�����
%dir_path%:

set /p mysql_bin_path=������mysql binĿ¼ȫ·�����磺E:\MySQL\bin����
cd %mysql_bin_path%

set /p username=���������ݿ��û�����

set /p password=���������ݿ����룺

rem ��������˻س�����������Ϊ���ַ���
if "%password%"=="" (
	set password= 
	echo �����˻س���������Ϊ���ַ���=%password% 
)

set /p db_name=���������ݿ�����

set /p table_name=�����������

set /p total_number=�������ܵ�����������

set /p data_number=�����뵥���ļ���Ҫ������������

set /a page_number=%total_number%/%data_number%+1
echo ����Ϊ%page_number%ҳ

set /p start_page=��������ʼҳ����0Ϊ��һҳ��1Ϊ�ڶ�ҳ���Դ����ƣ���
echo ��ʼҳ��=%start_page%

set /a var=%start_page%
set /a stop=%page_number%-1

echo ��ʼ�������ݽű�

rem ѭ�������ļ�
:loop_export
set /a offset=%var%*%data_number%
echo ��ʼ����=%offset%��ÿҳ����=%data_number%

rem -t��ʾֵ�������ݣ���������ṹ�������Ҫ��ṹ��ֱ��ȥ��-t
rem ����ʾ�ļ�������·��������ʵ�ʽ����޸ģ�Ҳ���Է�������ķ�ʽ�޸�Ϊ�û��������ʽ
mysqldump -u%username% -p%password% -t %db_name% %table_name% --where="1=1 limit %offset%,%data_number%" > f:\datas\%table_name%%var%.sql
echo ��ɵ����ļ�e:\datas\%table_name%%var%.sql

rem ����ļ�������ϣ��������ɵķ�����finish���������������ѭ��������loop_export��
if %var%==%stop% goto finish
set /a var+=1
goto loop_export

:finish
echo ȫ���������!!!
pause
