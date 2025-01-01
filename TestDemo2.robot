*** Settings ***

Test Setup    Open the browser with Mortgage Payment url   #tear setup method to launch url before starting the test cases
Test Teardown    Close Browser session             #tear down method, will close the browser once the below Tc is completed
Resource    resources.robot

*** Test Cases ***
Validate unSuccessful Login

    Enter User Name and Password   ${UserName}    ${invalidPassword}
    Wait until element is located in the page       ${IncorrectMessageLocator}
    Verify the displayed error message
    
Validate Successful Login

    Enter User Name and Password    ${UserName}    ${ValidPassword}
    Wait until element is located in the page    ${Checkout_button}
    Verify card title in the Shop page
    Select the mobile


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



Wait until element is located in the page
    [Arguments]    ${MessageLocator}
    Wait Until Element Is Visible    ${MessageLocator}
    
Verify the displayed error message
    #${errorMessage}    Get Text    ${IncorrectMessageLocator}       #${xxxxxxxx} is how we nee to declare a variable
    #Should Be Equal As Strings    ${errorMessage}    Incorrect username/password.
    Element Text Should Be    ${IncorrectMessageLocator}    Incorrect username/password.

Verify card title in the Shop page
    @{Expected_Mobile_List}   Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry         
    Log    ${Expected_Mobile_List}
    @{Actual_Mobile_list}    Get Webelements    xpath://h4[@class="card-title"]
    #Log    @{Actual_Mobile_list}
    @{Actual_Mobile_Text_list}    Create List

#use @ instead of $ to create the variable as a list and later use $ for value initialization

    FOR    ${Mobile}    IN    @{Actual_Mobile_list}
        ${MobileName}=    Get Text    ${Mobile}

        Log    Appending text: ${MobileName}
        Append To List    ${Actual_Mobile_Text_list}    ${MobileName}
        Log    ${Actual_Mobile_Text_list}
    END

    Lists Should Be Equal     ${Expected_Mobile_List}    ${Actual_Mobile_Text_list}

Select the mobile
    @{Actual_Mobile_list}    Get Webelements    xpath://h4[@class="card-title"]
    ${MobileCount}    Set Variable    1
    FOR    ${Mobile}    IN    @{Actual_Mobile_list}
        ${MobileName}=    Get Text    ${Mobile}
        Exit For Loop If    'Blackberry' == '${MobileName}'
             ${MobileCount}=    Evaluate     ${MobileCount}+1

    Click Button    xpath://body//app-root//app-card[${MobileCount}]//button
    END