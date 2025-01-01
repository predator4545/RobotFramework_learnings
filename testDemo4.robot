*** Settings ***

Test Setup    Open the browser with Mortgage Payment url   #tear setup method to launch url before starting the test cases
Test Teardown    Close Browser session             #tear down method, will close the browser once the below Tc is completed
Resource    resources.robot
Test Template    Validate unSuccessful Login


*** Test Cases ***    UserName    Password
Invalid_Username      GOAT        Vijay    #using this method, we could run the same TC's using different set of parameters
Invalid_Password      GOAT        Ajay
Invalid_strings       $#%@


#he Tc(Validate unSuccessful Login) is moved into keyword, bz that is no longer a test case, it's a Test template
#the above are considered as a tc's now
*** Keywords ***

Validate unSuccessful Login
#we need to add arguments in the below in this area too, to be abled to pass to be passed around
    [Arguments]    ${UserName}    ${invalidPassword}
    Enter User Name and Password   ${UserName}    ${invalidPassword}
    Wait until element is located in the page       ${IncorrectMessageLocator}
    Verify the displayed error message

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