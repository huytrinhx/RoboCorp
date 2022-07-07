*** Settings ***
Documentation       Template keyword resource.
Library        RPA.Browser.Selenium    auto_close=${False}
Library    String
Variables    MyVariables.py    
*** Keywords ***
Launch My GitHub
    Open Available Browser    ${MYURL}    maximized=True
    Wait Until Element Contains   ${HomePageLocator}    huytrinhx

Do String Operations
    [Arguments]    ${in_String}
    ${Substring}=    Get Substring    ${in_String}    5    10
    Log    ${Substring}