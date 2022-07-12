*** Settings ***
Resource    shared.robot
Library     RPA.Database


*** Test Cases ***
Normal Read Config
    &{Config}=    Initialize All Settings
    ${JsonConfig}=    Get From Dictionary    ${Config}    jsonConfig
    Should Contain    ${JsonConfig}    ProjectName

Read Config With Tables
    ${TableList}=    Create List    Table1    Table2
    ${JsonConfig}=    Initialize All Settings    ${TableList}
    FOR    ${table}    IN    @{TableList}
        ${ReadTable}=    Get Value From JSON    ${JsonConfig}    $.[${table}]
        ${rows}    ${columns}=    Get Table Dimensions    ${ReadTable}
        Should Not Be Equal    ${rows}    0
        Should Not Be Equal    ${columns}    0
    END
