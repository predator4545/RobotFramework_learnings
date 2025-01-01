*** Settings ***

Test Setup    Open the browser with Mortgage Payment url   #tear setup method to launch url before starting the test cases
Test Teardown    Close Browser session             #tear down method, will close the browser once the below Tc is completed
Resource    resources.robot

*** Test Cases ***
Retrieve email address form the child window

    Click On The Link And Switch To The Child Window
    Verify the child window
    Capture the mail address from the child window
    Get back to the main window
    Enter User Name and Password   ${UserName}    ${invalidPassword}


*** Keywords ***
Enter User Name and Password
    [Arguments]    ${user_name}    ${password}         #this is the syntax for arguments

    Input Text    id:username    ${user_name}
    Input Password    id:password    ${password}
    Click Button    css:input[value=user]
    Wait Until Element Is Visible    css:button[id=okayBtn]
    Click Button    css:button[id=okayBtn]
    Select From List By Label    css:select.form-control    Consultant
    Select Checkbox    terms
    Click Button    signInBtn                      #no need to mention locator as ID (optional),only for ID, not fpr other locators

Click on the link and switch to the child Window

    Click Link    link:Free Access to InterviewQues/ResumeAssistance/Material
    Sleep    5

Verify the child window

    Switch Window    NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST

Capture the mail address from the child window
    ${text}=    Get Text    css:p.red
    @{words}=    Split String    ${text}    ${SPACE}
    Log    ${words}

    FOR    ${index}    IN    @{words}
        Log    ${index}
        Exit For Loop If    '.com' in '${index}'

            Set Global Variable    ${email}    '${index}'
            Log    ${email}

    END

Get back to the main window
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username    ${email}



