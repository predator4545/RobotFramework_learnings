*** Settings ***
Documentation   To Validate the Login Form
...             The system specific keywords created here frfom our own    #need to use "..." to add more lines in the description

...             domain specific language

Library    SeleniumLibrary
Library    Collections
Library    String

*** Keywords ***
Open the browser with Mortgage Payment url
    Create Webdriver    Chrome
    Go To    ${HomePageUrl}
    #Open Browser      http://www.yoursite.com    chrome

Close Browser session 
    Close Browser

*** Variables ***
${IncorrectMessageLocator}    css:.alert-danger   
${HomePageUrl}    https://rahulshettyacademy.com/loginpagePractise/
${UserName}    rahulshettyacademy
${invalidPassword}    0987654321
${ValidPassword}    learning
${Checkout_button}    css:.nav-link.btn.btn-primary


