*** Settings ***
Documentation     Verifică navigarea în cadrul aplicației pentru secțiunile principale.
Library           SeleniumLibrary

*** Variables ***
${URL}            https://localhost:44488/#/
${HOME_TITLE}     xpath=//h1[contains(text(), 'GreenScape: Plantează și iubește')]

${LEGUME}     xpath=//div[@id='legume']
${FRUCTE}         xpath=//div[@id='fructe']
${FLORI}        xpath=//div[@id='flori']
${BROWSER}        Chrome

*** Test Cases ***
Testare Navigare Plante
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