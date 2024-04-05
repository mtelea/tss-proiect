*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://localhost:7211
${REGISTER_USER_ENDPOINT}    /register/register-user
${VALID_EMAIL}    use1r52@example.com
${VALID_USERNAME}    someusername5
${VALID_PASSWORD}    somepassword5

*** Test Cases ***
Register User with Valid Data
    [Documentation]    Test registering a user with valid data
    [Tags]    register    valid
    ${request_body}    Create Dictionary    email=${VALID_EMAIL}    userName=${VALID_USERNAME}    password=${VALID_PASSWORD}    confirmPassword=${VALID_PASSWORD} 
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${response}=    POST    url=${BASE_URL}${REGISTER_USER_ENDPOINT}    json=${request_body}    headers=${headers}    verify=${False}
    ${response_body}=    Convert To String    ${response.content}
    Log    ${response_body}
    Status Should Be    200    ${response}

Does not Register User with duplicate username
    [Documentation]    Test registering a user with dublicate data
    [Tags]    register    invalid
    ${request_body}    Create Dictionary    email=${VALID_EMAIL}    userName=${VALID_USERNAME}    password=${VALID_PASSWORD}    confirmPassword=${VALID_PASSWORD} 
    ${headers}    Create Dictionary    Content-Type    application/json
    ${response}    Run Keyword And Ignore Error    POST    url=${BASE_URL}${REGISTER_USER_ENDPOINT}    json=${request_body}    headers=${headers}    verify=${False}
    ${response_body}=    Convert Json To String    ${response}
    Log    ${response}
    Should Be Equal    FAIL    ${response[0]}

