@echo off

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Link Consolas with Meiryo UI (for Japanese)
:: @author Kenichi Maehashi
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Note: Administrative privilege required

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v Consolas /t REG_MULTI_SZ /d "meiryo.ttc,Meiryo UI" /f


:: Another examples ---
:: reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v Consolas /t REG_MULTI_SZ /d "meiryo.ttc,メイリオ" /f
:: reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v Consolas /t REG_MULTI_SZ /d "msgothic.ttc,MS PGothic" /f
