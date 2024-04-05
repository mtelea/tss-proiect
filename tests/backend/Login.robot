*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}   https://localhost:7211
${LOGIN_ENDPOINT}    /api/Login/login
${VALID_USERNAME}    maria
${VALID_PASSWORD}    admin1234

*** Test Cases ***
Test Successful Login
    [Documentation]    Test for successful login
    ${REQUEST_BODY}    Set Variable    { "UserName": "maria", "Password": "admin1234"}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${response}=    POST    ${BASE_URL}${LOGIN_ENDPOINT}    data=${request_body}    headers=${headers}    verify=${False}
    Should Be Equal As Strings    ${response.status_code}    200


Test Failed Login
    [Documentation]    Test for failed login
    ${REQUEST_BODY}    Set Variable    { "UserName": "maria", "Password": "admin12377774"}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${response}=    Run Keyword And Warn On Failure    POST  ${BASE_URL}${LOGIN_ENDPOINT}    data=${request_body}    headers=${headers}    verify=${False}
    Should Be Equal As Strings    ${response[0]}    FAIL
