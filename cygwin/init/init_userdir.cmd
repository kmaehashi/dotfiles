@echo off

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Synchronize User Directory between Cygwin and Windows
:: @author Kenichi Maehashi
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Note: Administrative privilege required

cd %SystemDrive%\cygwin\home
move %USERNAME%\* %USERPROFILE%
rmdir %USERNAME%
mklink /j %USERNAME% %USERPROFILE%
