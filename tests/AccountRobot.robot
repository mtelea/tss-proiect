*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}           https://localhost:44488/account
${VALID_EMAIL}        telea.maria3@gmail.com
${INVALID_EMAIL}      invalid_user@example.com
${VALID_RESET_TOKEN}  CfDJ8PaAYlez63FEjWI1wbOwFNpwfcMt4b2T5QLUZwV32i0McwzD3NDLwoit0zUvCPBKJEQRQ1iv%2BwCoBkZY5b3BfkvXyDtqtnI7WCHqL8vFS4Bq5wn8XJPqEoACz8Er%2BWrWqTDGDnREtHr9LAFPDU%2Fa86Fni0TZvFGLfZ62nEuMTOCBzdADriGOUXJWSjxNU1nsZdIxbWXUP1xjyyMX%2FQZMkpIi1hgbVkpMd9iRd7UyZYge
${INVALID_RESET_TOKEN}  invalid_reset_token
${VALID_NEW_PASSWORD}  NewPassword123!
${INVALID_NEW_PASSWORD}  InvalidPassword

*** Test Cases ***
Test Forgot Password Succesful
    [Documentation]    Test ForgotPassword method
    ${request_body}=    Create Dictionary    Email=${VALID_EMAIL}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${response}=    POST    ${BASE_URL}/forgot-password    json=${request_body}    headers=${headers}    verify=${False}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()["message"]}    Password reset email sent successfully

Test Forgot Password With Invalid Email
    [Documentation]    Test ForgotPassword method with invalid email
    ${request_body}=    Create Dictionary    Email=${INVALID_EMAIL}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${response}=    Run Keyword And Warn On Failure    POST  ${BASE_URL}/forgot-password   data=${request_body}    headers=${headers}    verify=${False}
    Should Be Equal As Strings    ${response[0]}    FAIL

Test Reset Password Succesful
    [Documentation]    Test ForgotPassword method
    ${request_body}=    Create Dictionary    Email=${VALID_EMAIL}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${response}=    POST    ${BASE_URL}/forgot-password    json=${request_body}    headers=${headers}    verify=${False}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()["message"]}    Password reset email sent successfully

Test Reset Password Unsuccesful
    [Documentation]    Test ForgotPassword method
    ${request_body}=    Create Dictionary    Email=${INVALID_EMAIL}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${response}=    Run Keyword And Warn On Failure    POST  ${BASE_URL}/forgot-password   data=${request_body}    headers=${headers}    verify=${False}
    Should Be Equal As Strings    ${response[0]}    FAIL