@echo off
title Script de Logout e Limpeza Profunda v3
echo ===================================================
echo AVISO: ISSO VAI FECHAR SEUS NAVEGADORES E DELETAR
echo DADOS DE LOGIN, CACHE, HISTORICO E CREDENCIAIS!
echo ===================================================
pause

echo.
echo [1/7] Fechando navegadores em segundo plano...
taskkill /F /IM chrome.exe /T >nul 2>&1
taskkill /F /IM msedge.exe /T >nul 2>&1
taskkill /F /IM firefox.exe /T >nul 2>&1
taskkill /F /IM brave.exe /T >nul 2>&1

echo.
echo [2/7] Limpando perfis, senhas e cache de Navegadores...
:: Chrome
rmdir /S /Q "%LOCALAPPDATA%\Google\Chrome\User Data" >nul 2>&1
:: Edge
rmdir /S /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data" >nul 2>&1
:: Firefox
rmdir /S /Q "%APPDATA%\Mozilla\Firefox\Profiles" >nul 2>&1
rmdir /S /Q "%LOCALAPPDATA%\Mozilla\Firefox\Profiles" >nul 2>&1
:: Brave
rmdir /S /Q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data" >nul 2>&1

echo.
echo [3/7] Limpando Credenciais do Git, GitHub CLI e Copilot...
del /F /Q "%USERPROFILE%\.git-credentials" >nul 2>&1
del /F /Q "%USERPROFILE%\.gitconfig" >nul 2>&1
rmdir /S /Q "%USERPROFILE%\.config\gh" >nul 2>&1
rmdir /S /Q "%APPDATA%\GitHub CLI" >nul 2>&1
:: GitHub Copilot
rmdir /S /Q "%USERPROFILE%\.config\github-copilot" >nul 2>&1
rmdir /S /Q "%LOCALAPPDATA%\github-copilot" >nul 2>&1
rmdir /S /Q "%USERPROFILE%\AppData\Local\github-copilot" >nul 2>&1

echo.
echo [4/7] Limpando Opencode, Antigravity CLI e Gemini CLI...
:: Opencode
rmdir /S /Q "%USERPROFILE%\.opencode" >nul 2>&1
rmdir /S /Q "%APPDATA%\opencode" >nul 2>&1
rmdir /S /Q "%LOCALAPPDATA%\opencode" >nul 2>&1
:: Antigravity
rmdir /S /Q "%USERPROFILE%\.antigravity" >nul 2>&1
rmdir /S /Q "%USERPROFILE%\.config\antigravity" >nul 2>&1
rmdir /S /Q "%APPDATA%\antigravity" >nul 2>&1
rmdir /S /Q "%LOCALAPPDATA%\antigravity" >nul 2>&1
:: Gemini CLI
rmdir /S /Q "%USERPROFILE%\.gemini" >nul 2>&1
rmdir /S /Q "%USERPROFILE%\.config\gemini" >nul 2>&1
rmdir /S /Q "%APPDATA%\gemini" >nul 2>&1
rmdir /S /Q "%LOCALAPPDATA%\gemini" >nul 2>&1

echo.
echo [5/7] Limpando CLIs de Nuvem, Hospedagem e Pacotes...
:: AWS, Azure, Docker
rmdir /S /Q "%USERPROFILE%\.docker" >nul 2>&1
rmdir /S /Q "%USERPROFILE%\.aws" >nul 2>&1
rmdir /S /Q "%USERPROFILE%\.azure" >nul 2>&1
:: Google Cloud e Firebase
rmdir /S /Q "%APPDATA%\gcloud" >nul 2>&1
rmdir /S /Q "%USERPROFILE%\.config\configstore" >nul 2>&1
:: Vercel, Netlify, Heroku
rmdir /S /Q "%USERPROFILE%\.vercel" >nul 2>&1
rmdir /S /Q "%USERPROFILE%\.netlify" >nul 2>&1
del /F /Q "%USERPROFILE%\.netrc" >nul 2>&1
:: Kubernetes (Opcional - apaga acesso a clusters)
rmdir /S /Q "%USERPROFILE%\.kube" >nul 2>&1
:: Gerenciadores de Pacotes (NPM, Yarn, Pip)
del /F /Q "%USERPROFILE%\.npmrc" >nul 2>&1
del /F /Q "%USERPROFILE%\.yarnrc" >nul 2>&1
del /F /Q "%USERPROFILE%\.pypirc" >nul 2>&1

echo.
echo [6/7] Limpando dados locais de Editores (VS Code) e SSH...
:: VS Code Global Storage (Tokens de extensoes)
rmdir /S /Q "%APPDATA%\Code\User\globalStorage" >nul 2>&1
:: Opcional: Limpar chaves SSH (Remova os "::" abaixo se quiser destruir as chaves locais)
:: rmdir /S /Q "%USERPROFILE%\.ssh" >nul 2>&1

echo.
echo [7/7] Limpando o Gerenciador de Credenciais do Windows...
:: Remove credenciais de rede ligadas as ferramentas
for /F "tokens=1,* delims= " %%G in ('cmdkey /list ^| findstr /i "git github copilot vscode opencode antigravity azure aws docker gemini gcloud firebase vercel netlify heroku"') do (
    echo Deletando credencial: %%H
    cmdkey /delete:%%H >nul 2>&1
)

echo.
echo ===================================================
echo LIMPEZA CONCLUIDA COM SUCESSO! 
echo O sistema foi deslogado da maioria das ferramentas de dev.
echo ===================================================
pause
