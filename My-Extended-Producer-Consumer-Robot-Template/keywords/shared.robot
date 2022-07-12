*** Settings ***
Documentation       Implementation of actions that both producer-consumer will use.

Library             RPA.JSON
Library             RPA.Tables
Library             RPA.Excel.Files
Library             Collections
Library             Tables


*** Variables ***
${JsonConfigFilepath}=      %{ROBOT_ROOT}/devdata/env.json
${ExcelConfigFilepath}=     %{ROBOT_ROOT}/devdata/config.xlsx
@{EMPTY_LIST}=
&{EMPTY_DICT}=


*** Keywords ***
Initialize All Settings
    [Documentation]    Return a dictionary that store the jsonconfig and all the tables
    [Arguments]    ${tables}=${EMPTY_LIST}
    ${OutputDict}=    Copy Dictionary    ${EMPTY_DICT}
    # Reading values from env.json
    ${JsonConfig}=    Load JSON from file    ${JsonConfigFilepath}
    Set To Dictionary    ${OutputDict}    jsonConfig    ${JsonConfig}
    # Reading tables from config.xlsx and serialize it to string
    # then add that to JsonConfig variable
    FOR    ${table}    IN    @{tables}
        Log    ${table}
        Open Workbook    ${ExcelConfigFilepath}
        ${data}=    Read Worksheet As Table    name=${table}
        Set To Dictionary    ${OutputDict}    ${table}    ${data}
    END
    RETURN    ${OutputDict}
