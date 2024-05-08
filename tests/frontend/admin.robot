*** Settings ***
Documentation     Verifică funcțiile utilizate de către administrator
Library           SeleniumLibrary

*** Variables ***
${URL}            https://localhost:44488/#/
${HOME_TITLE}     xpath=//h1[contains(text(), 'GreenScape: Plantează și iubește')]
${HOME_LOGIN}     xpath=//h2[contains(text(), 'Ai cont ?')]
${ADMIN_BUTTON}    xpath=//a[contains(text(), 'Admin')]
${ADD_PLANT_BUTTON}    xpath=/html/body/app-root/body/div/app-admin/div/button
${LOGIN_BUTTON_PATH}    css:.log-home-text
${BROWSER}        Chrome

${USERNAME_FIELD}    id=usernameId
${PASSWORD_FIELD}    id=passwordId
${LOGIN_BUTTON}    xpath=//button[contains(text(), 'Conecteaza-te')]
${USERNAME}          cristianbb
${PASSWORD}          parola123

${NAME_FIELD}    nameId
${TYPE_FIELD}    typeId
${SPECIES_FIELD}    speciesId
${DESCRIPTION_FIELD}    descriptionId

${PLANT_NAME}    Pepene Verde
${PLANT_SPECIES}    Citrullus lanatus
${PLANT_DESCRIPTION}     Este cultivat în lumea întreagă pentru fructul său voluminos și comestibil, având o coajă dură și un miez necompartimentat.

${EDITED_PLANT_NAME}    Pepene Galben
${EDITED_PLANT_SPECIES}    Cucumis melo
${EDITED_PLANT_DESCRIPTION}     Se cultivă pentru fructul său, care se coace vara, conține multă apă și este de gust dulce.

${SAVE_PLANT_BUTTON}    xpath=//*[@id="savePlantDetails"]
${PLANT_IMAGE_FIELD}    xpath=/html/body/app-root/body/div/app-add-plant/div/input
${EDIT_IMAGE_FIELD}    xpath=/html/body/app-root/body/div/app-admin-details/div/div/div/input
${EDIT_PLANT_BUTTON}    xpath=//tr[.//td[text()='${PLANT_NAME}']]//button[@id="edit"]
${DELETE_PLANT_BUTTON}    xpath=//tr[.//td[text()='${EDITED_PLANT_NAME}']]//button[@id="delete"]

*** Test Cases ***
Testare Functii Admin
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

    Wait Until Page Contains Element    ${ADMIN_BUTTON}
    Click Element    ${ADMIN_BUTTON}
    Wait Until Page Contains Element    ${ADD_PLANT_BUTTON}
    Click Element    ${ADD_PLANT_BUTTON}
    Wait Until Page Contains    Adauga planta

    Input Text    ${NAME_FIELD}    ${PLANT_NAME}
    Select From List By Index    ${TYPE_FIELD}    0
    Input Text    ${SPECIES_FIELD}    ${PLANT_SPECIES}
    Input Text    ${DESCRIPTION_FIELD}    ${PLANT_DESCRIPTION}
    Click Element    ${SAVE_PLANT_BUTTON}
    Choose File    ${PLANT_IMAGE_FIELD}    ${CURDIR}/pepene_verde.jpg
    Wait Until Page Contains    Added plant successfully

    Click Element    ${ADMIN_BUTTON}
    Wait Until Page Contains Element    ${ADD_PLANT_BUTTON}
    Page Should Contain    ${PLANT_NAME}
    Click Element    ${EDIT_PLANT_BUTTON}
    Wait Until Page Contains    Editeaza planta
    Input Text    ${NAME_FIELD}    ${EDITED_PLANT_NAME}
    Select From List By Index    ${TYPE_FIELD}    1
    Input Text    ${SPECIES_FIELD}    ${EDITED_PLANT_SPECIES}
    Input Text    ${DESCRIPTION_FIELD}    ${EDITED_PLANT_DESCRIPTION}
    Choose File    ${EDIT_IMAGE_FIELD}    ${CURDIR}/pepene_galben.jpg
    Click Element    ${SAVE_PLANT_BUTTON}
    Wait Until Page Contains    Saved plants details successfully

    Click Element    ${ADMIN_BUTTON}
    Wait Until Page Contains Element    ${ADD_PLANT_BUTTON}
    Page Should Contain    ${EDITED_PLANT_NAME}
    Click Element    ${DELETE_PLANT_BUTTON}
    Wait Until Page Contains    Deleted successfully
    Page Should Contain     Deleted successfully

    Close Browser
