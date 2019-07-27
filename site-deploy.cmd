setlocal
@echo off
echo This is my local deploy...
rem echo Environment:
rem set
rem echo Is deploy on the path?
rem  where deploy.cmd

call :CloneOrSyncGit https://github.com/rlittletht/TestReact.git %DEPLOYMENT_SOURCE%\..\SubRepos\TestReactRepo1 production
call :CloneOrSyncGit https://github.com/rlittletht/TestReact.git %DEPLOYMENT_SOURCE%\..\SubRepos\TestReactRepo2 production

rem ::: Now actually deploy using deploy.cmd

rem pushd %DEPLOYMENT_SOURCE%\..\SubRepos\TestReactRepo1\NodeJsWebApp1
rem call npm install
rem del /q dist\*
rem call node_modules\.bin\tsc
rem call node_modules\.bin\webpack-cli app.tsx --config webpack-config.js
rem popd

call :DeploySubSite %DEPLOYMENT_SOURCE%\..\SubRepos\TestReactRepo1\NodeJsWebApp1 %DEPLOYMENT_TARGET%\rtest
call :DeploySubSite %DEPLOYMENT_SOURCE%\..\SubRepos\TestReactRepo1\NodeJsWebApp1 %DEPLOYMENT_TARGET%\rtest3

goto :EOF

rem ::::: CloneOrSyncGit ::::::::

:CloneOrSyncGit

if exist %2 goto SyncGit
git clone %1 %2 -b %3
goto :EOF

:SyncGit
pushd %2
git pull
popd
goto :EOF

rem ::::: DeploySubSite ::::::::

:DeploySubSite
setlocal

set DEPLOYMENT_SOURCE=%1
set DEPLOYMENT_TARGET=%2

call deploy.cmd
goto :EOF
