Configuration
=============

Setup
-----

Mac OS X:

```
ln -s ~/dotfiles/SublimeText/Packages/User ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User
```

Windows:

```
cmd /c mklink /j "%USERPROFILE%\AppData\Roaming\Sublime Text 2\Packages\User" "%USERPROFILE%\dotfiles\SublimeText\Packages\User"
```

Session Config
----------------------------------------

- View > Hide Minimap
- View > Side Bar > Show Open Files

Packages
--------

* Package Control (setup proxy if needed)
  * https://sublime.wbond.net/installation#st2
* ConvertToUTF8
* SideBarEnhancements
  * https://github.com/titoBouzout/SideBarEnhancements/issues/172
* IMESupport (on Windows only)
* GoSublime
