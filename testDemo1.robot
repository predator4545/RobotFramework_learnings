*** Settings ***
Documentation   To Validate the Login Form        #is used ti describe the test cases
Library    SeleniumLibrary
Test Teardown    Close Browser             #tear down method, will close the browser once the below Tc is completed

*** Variables ***
${IncorrectMessageLocator}    css:.alert-danger          #can store locators in a variable



*** Test Cases ***
Validate unSuccessful Login
    Open the browser with Mortgage Payment url
    Enter User Name and Password
    Wait for the error message
    Verify the displayed error message


*** Keywords ***
Open the browser with Mortgage Payment url
    Create Webdriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/

Enter User Name and Password
    Input Text    id:username    rahulShetty
    Input Password    id:password    987654321
    Click Button    signInBtn                      #no need to mention locator as ID (optional)

Wait for the error message
    Wait Until Element Is Visible    ${IncorrectMessageLocator}
    
Verify the displayed error message
    #${errorMessage}    Get Text    ${IncorrectMessageLocator}       #${xxxxxxxx} is how we nee to declare a variable
    #Should Be Equal As Strings    ${errorMessage}    Incorrect username/password.

    Element Text Should Be    ${IncorrectMessageLocator}    Incorrect username/password.