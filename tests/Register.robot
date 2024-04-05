*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}    https://localhost:7211
${REGISTER_USER_ENDPOINT}    /register/register-user
${VALID_EMAIL}    username@example.com
${VALID_USERNAME}=    username
${VALID_PASSWORD}    password

*** Test Cases ***
Register User with Valid Data
    [Documentation]    Test registering a user with valid data
    [Tags]    register    valid
    ${random_prefix}=    Generate Random String    7
    ${final_email}=    Catenate    SEPARATOR=    ${random_prefix}    ${VALID_EMAIL}
    ${final_username}=    Catenate    SEPARATOR=    ${random_prefix}    ${VALID_USERNAME}
    ${request_body}    Create Dictionary    email=${final_email}    userName=${final_username}    password=${VALID_PASSWORD}    confirmPassword=${VALID_PASSWORD} 
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${response}=    POST    url=${BASE_URL}${REGISTER_USER_ENDPOINT}    json=${request_body}    headers=${headers}    verify=${False}
    ${response_body}=    Convert To String    ${response.content}
    Log    ${response_body}
    Dictionary Should Contain Value    ${response.json()}    Registration successful

Does not Register User with duplicate username
    [Documentation]    Test registering a user with dublicate data
    [Tags]    register    invalid
    ${request_body}    Create Dictionary    email=${VALID_EMAIL}    userName=${VALID_USERNAME}    password=${VALID_PASSWORD}    confirmPassword=${VALID_PASSWORD} 
    ${headers}    Create Dictionary    Content-Type    application/json
    ${response}    Run Keyword And Ignore Error    POST    url=${BASE_URL}${REGISTER_USER_ENDPOINT}    json=${request_body}    headers=${headers}    verify=${False}
    ${response_body}=    Convert Json To String    ${response}
    Log    ${response}
    Should Be Equal    FAIL    ${response[0]}

