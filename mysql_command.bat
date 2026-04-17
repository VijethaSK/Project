@echo off
REM Quick MySQL Command Line Access
REM This opens MySQL command line for the hotel_dbms database

echo Opening MySQL command line...
echo.
echo Database: hotel_dbms
echo User: root
echo.
echo Useful commands once inside MySQL:
echo   USE hotel_dbms;
echo   SHOW TABLES;
echo   SELECT * FROM room;
echo   SELECT * FROM user;
echo   SELECT * FROM reservation;
echo   EXIT;  (to quit)
echo.

REM Try to find MySQL in common XAMPP locations
if exist "D:\xampp\mysql\bin\mysql.exe" (
    D:\xampp\mysql\bin\mysql.exe -u root
    goto :end
)

if exist "C:\xampp\mysql\bin\mysql.exe" (
    C:\xampp\mysql\bin\mysql.exe -u root
    goto :end
)

echo MySQL not found!
echo Please check your XAMPP installation path.
pause
exit

:end

