## Testare automată folosind un robot - Robot Framework

<p align="center">
<img src="/robot-framework.png" width="100"/>
</p>

Proiect pentru materia *Testarea sistemelor software* în care am implementat diverse scenarii de testare automată folosind Robot Framework.
Aplicația testată ”Greenscape” este o aplicație web, componenta frontend fiind scrisă în Angular, cea backend în C# cu .NET, iar persistența datelor este realizată cu ajutorul SQLServer.

Echipa noastră:
- Telea Maria
- Draghioti Andreea
- Borcan Cristian

### Useful links:
[Link către Youtube - Demo RobotFramework](https://www.youtube.com/watch?v=bGSA3kx8zsE)

[Link către Youtube - Demo UiPath](https://www.youtube.com/watch?v=eizZcer-R3M)

[Link către prezentarea Powerpoint](https://docs.google.com/presentation/d/1K21oRCAtrjXaDZAdQ__jpQ7afUIlCCl4CynDpbhSFfc/edit?usp=sharing) în care am inclus explicații, demo-uri, comparații și diverse diagrame.

### Raport AI:

Am folosit ChatGPT 3.5 pentru a încerca să generăm codul pentru un robot care să testeze funcționalitatea endpoint-ului de Login (happy flow) pe partea de back-end.
Introducând următorul prompt:
"Write a succesfull login test case using robotframework for the method below: "
```cs
public LoginController(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager)
{
    _signInManager = signInManager;
    _userManager = userManager;
}

[HttpPost("login")]
public async Task<IActionResult> Login([FromBody] LoginModel model)
{
    if (ModelState.IsValid)
    {
        var result = await _signInManager.PasswordSignInAsync(model.UserName, model.Password, model.RememberMe, lockoutOnFailure: false);

        if (result.Succeeded)
        {
            return Ok(new { Message = "Login successful" });
        }

        return BadRequest(new { Message = "Login failed", Errors = "Invalid login attempt" });
    }

    return BadRequest(new { Message = "Invalid login data" });
}
```


Și am primit ca răspuns următorul cod:
```
*** Settings ***
Library           RequestsLibrary
Library           OperatingSystem

*** Variables ***
${BASE_URL}       http://your-api-url.com
${LOGIN_ENDPOINT}    /login
${USERNAME}       your_username
${PASSWORD}       your_password

*** Test Cases ***
Successful Login Test
    [Documentation]    Test successful login scenario
    Create Session    loginSession    ${BASE_URL}
    ${headers}=    Create Dictionary    Content-Type    application/json
    ${data}=    Create Dictionary    UserName=${USERNAME}    Password=${PASSWORD}    RememberMe=True
    ${response}=    Post Request    loginSession    ${LOGIN_ENDPOINT}    headers=${headers}    json=${data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    "Login successful"
    Close All Sessions
```

Am rulat robotul folosind codul primit, modificând datele de intrare cu unele corecte pentru aplicația noastră, dar la rularea acestuia am constatat faptul că în codul primit există keyword-uri deprecated sau chiar inexistente pentru versiunea actuală din Robot Framework, probabil datorită limitărilor modelului AI, ce folosește date mai vechi de 2021. În consecință, robotul nu este funcțional, iar efortul necesar modificării acestuia pentru a-l aduce într-o stare funcțională pare să fie mai mare decât cel pentru a îl crea manual. Am atașat mai jos un screenshot cu codul în care observăm keyword-urile folosite în mod eronat și erorile primite la rulare.

<p align="center">
<img src="/raport_ai.png" width="500"/>
</p>