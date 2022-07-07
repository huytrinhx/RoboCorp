*** Settings ***
Documentation       Template keyword resource.
Library        RPA.Browser.Selenium    auto_close=${False}
Variables    MyVariables.py    
*** Keywords ***
Launch My GitHub
    Open Available Browser    ${MYURL}    maximized=True
    Wait Until Element Contains   ${HomePageLocator}    huytrinhx
