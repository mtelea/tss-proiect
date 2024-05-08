*** Settings ***
Documentation     Verifică functinalitatea de login.
Library           SeleniumLibrary

*** Variables ***
${URL}            https://localhost:44488/#/
${HOME_TITLE}     xpath=//h1[contains(text(), 'GreenScape: Plantează și iubește')]
${HOME_LOGIN}     xpath=//h2[contains(text(), 'Ai cont ?')]
${LOGIN_BUTTON_PATH}    css:.log-home-text
${BROWSER}        Chrome

${USERNAME_FIELD}    id=usernameId
${PASSWORD_FIELD}    id=passwordId
${LOGIN_BUTTON}    xpath=//button[contains(text(), 'Conecteaza-te')]
${USERNAME}          andreeatest
${PASSWORD}          andreeatest

*** Test Cases ***
Testare Login Successful
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${HOME_TITLE}

    Wait Until Keyword Succeeds    5x    5s    Scroll Element Into View    ${LOGIN_BUTTON_PATH}
    Wait Until Keyword Succeeds    5x    5s    Click Element    ${HOME_LOGIN}
    Wait Until Page Contains    Conecteaza-te
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Conectare realizată cu succes! Veți fi redirecționat către pagina de start.
    Close Browser

Testare Login Cu Date Invalide
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${HOME_TITLE}

    Wait Until Keyword Succeeds    5x    5s    Scroll Element Into View    ${LOGIN_BUTTON_PATH}
    Wait Until Keyword Succeeds    5x    5s    Click Element    ${HOME_LOGIN}
    Wait Until Page Contains    Conecteaza-te
    Input Text    ${USERNAME_FIELD}    emailInvalid
    Input Text    ${PASSWORD_FIELD}    parolaInvalida
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Conectarea a esuat!
    Close Browser

Testare mesaje de validare a campului de username
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${HOME_TITLE}

    Wait Until Keyword Succeeds    5x    5s    Scroll Element Into View    ${LOGIN_BUTTON_PATH}
    Wait Until Keyword Succeeds    5x    5s    Click Element    ${HOME_LOGIN}
    Wait Until Page Contains    Conecteaza-te
    Input Text    ${USERNAME_FIELD}    a
    Wait Until Page Contains    Your username must have at least 3 characters.
    Close Browser

Testare mesaje de validare a campului de password
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${HOME_TITLE}

    Wait Until Keyword Succeeds    5x    5s    Scroll Element Into View    ${LOGIN_BUTTON_PATH}
    Wait Until Keyword Succeeds    5x    5s    Click Element    ${HOME_LOGIN}
    Wait Until Page Contains    Conecteaza-te

    Click Element    ${PASSWORD_FIELD}
    Click Element    ${USERNAME_FIELD}
    Wait Until Page Contains    Please enter your password.

    Close Browser