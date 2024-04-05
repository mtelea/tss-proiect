*** Settings ***
Documentation     Verifică navigarea în cadrul aplicației pentru secțiunile principale.
Library           SeleniumLibrary

*** Variables ***
${URL}            https://localhost:44488/#/
${HOME_TITLE}     xpath=//h1[contains(text(), 'GreenScape: Plantează și iubește')]
${HOME_LOGIN}     xpath=//h2[contains(text(), 'Ai cont ?')]

${LEGUME}     xpath=//div[@id='legume']
${FRUCTE}         xpath=//div[@id='fructe']
${FLORI}        xpath=//div[@id='flori']
${BROWSER}        Chrome

${USERNAME_FIELD}    id=usernameId
${PASSWORD_FIELD}    id=passwordId
${LOGIN_BUTTON}    xpath=//button[contains(text(), 'Conecteaza-te')]
${USERNAME}          andreeatest
${PASSWORD}          andreeatest

*** Test Cases ***
Testare Navigare
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${HOME_TITLE}

    Click Element    ${LEGUME}
    Wait Until Page Contains    Castravete
    Go Back
    Wait Until Page Contains Element    ${HOME_TITLE}

    Click Element    ${FRUCTE}
    Wait Until Page Contains    Mure
    Go Back
    Wait Until Page Contains Element    ${HOME_TITLE}

    Click Element    ${FLORI}
    Wait Until Page Contains    Begonie
    Go Back
    Wait Until Page Contains Element    ${HOME_TITLE}

    Close Browser

Testare Login Successful
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${HOME_TITLE}

    Click Element    ${HOME_LOGIN}
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

    Click Element    ${HOME_LOGIN}
    Wait Until Page Contains    Conecteaza-te
    Input Text    ${USERNAME_FIELD}    emailInvalid
    Input Text    ${PASSWORD_FIELD}    parolaInvalida
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Conectarea a esuat!
    Close Browser