@echo off

:begin

set /p dir_path=请输入mysql所在磁盘路径如:e，（如果当前磁盘即为所在磁盘，则直接回车）：
%dir_path%:

set /p mysql_bin_path=请输入mysql bin目录全路径（如：E:\MySQL\bin）：
cd %mysql_bin_path%

set /p username=请输入数据库用户名：
echo %username%

set /p password=请输入数据库密码：
echo %password%
rem 如果按下了回车键，则设置为空字符串
if "%password%"=="" set password= 
echo 按下了回车键，设置为空字符串=%password% 

set /p db_name=请输入数据库名：
echo %db_name%

set /p table_name=请输入表名：
echo %table_name%

set /p total_number=请输入总的数据条数：
echo 总条数=%total_number%

set /p data_number=请输入单个文件需要导出的条数：
echo 每页显示条数=%data_number%

set /a page_number=%total_number%/%data_number%+1
echo 共分为%page_number%页

set /p start_page=请输入起始页数（0为第一页，1为第二页，以此类推）：
echo 起始页数=%start_page%

set /a var=%start_page%
set /a stop=%page_number%-1
echo 停止的索引点=%stop%

echo 开始导出数据脚本

rem 循环导出文件
:loop_export

set /a offset=%var%*%data_number%
echo 起始数量=%offset%，每页条数=%data_number%

mysqldump -u%username% -p%password% -t %db_name% %table_name% --where="1=1 limit %offset%,%data_number%" > e:\gaoxiaobao\datas\%table_name%%var%.sql
echo 完成导出文件e:\gaoxiaobao\datas\%table_name%%var%.sql

rem 如果文件生成完毕，则进入完成的方法（finish），否则继续进入循环方法（loop_export）
if %var%==%stop% goto finish
set /a var+=1
goto loop_export

:finish
echo 生成完毕!!!
pause
