*** Settings ***
Library     Collections
Library     RPA.Excel.Files
Library     RPA.Robocorp.WorkItems
Library     RPA.Tables
Library     RPA.Email.Exchange
Library     RPA.Browser
Library     Screenshot
Resource    shared.robot


*** Variables ***
@{CONFIG}
${ENQUEUE_TABLE}
${ERROR_MESSAGE}


*** Tasks ***
Main
    TRY
        @{CONFIG}=    Initialize
        ${ENQUEUE_TABLE}=    Get New Cases    ${CONFIG}
        Load Queue    ${CONFIG}    ${ENQUEUE_TABLE}
    EXCEPT    ${BRE}    type=start
        Log    ${BRE}
        Email Users Error Message    ${CONFIG}    ${ERROR_MESSAGE}
    EXCEPT    ${SE}    type=start
        Take Screenshot
        Email Users Error Message    ${CONFIG}    ${ERROR_MESSAGE}
    FINALLY
        ${rows_count}    ${columns_count}=    Get Table Dimensions    ${ENQUEUE_TABLE}
        IF    ${rows_count} == 0
            Log    No queue data to load
        ELSE
            Email End Users Enqueue Data    ${CONFIG}    ${ENQUEUE_TABLE}
        END
        Closing Applications
    END


*** Keywords ***
Initialize
    [Documentation]    Retrieve all configurations and credentials
    ...    Launching all target applications
    ...    If fail, take a screenshot and get to closing stage
    &{Config}=    Initialize All Settings
    Initialize All Applications    ${Config}
    RETURN    ${Config}

Get New Cases
    [Arguments]    ${in_Config}
    # Include steps to navigate to source systems to retrieve the data
    # Output as datatable
    ${ENQUEUE_TABLE}=    Define Enqueue Table
    ${row_count}    ${column_count}=    Get Table Dimensions    ${ENQUEUE_TABLE}
    Log    Detected ${row_count} new transactions
    RETURN    ${ENQUEUE_TABLE}

Reconcile With Past transactions
    [Documentation]    This module is optional
    ...    The purpose of this module is to potential loading duplicate work which would
    ...    waste bot runtime
    [Arguments]    ${in_EnqueueTable}
    RETURN    ${in_EnqueueTable}

Load Queue
    [Arguments]    ${in_Config}    ${in_Table}
    FOR    ${row}    IN    @{in_Table}
        ${variables}=    Create Dictionary
        ...    Name=${row}[Name]
        ...    Zip=${row}[Zip]
        ...    Item=${row}[Item]
        Create Output Work Item
        ...    variables=${variables}
        ...    save=True
    END
    ${row_count}    ${column_count}=    Get Table Dimensions    ${in_Table}
    Log    Finished loading ${row_count} transactions

Closing
    Log    Closing

Define Enqueue Table
    [Documentation]    Initialize and define structure of enqueue table
    @{columns}=    Create List    ColumnA    ColumnB    ColumnC
    ${enqueueTable}=    Create Table    columns=${columns}
    RETURN    ${enqueueTable}

Email End Users Enqueue Data
    [Documentation]    Inform users of data being enqueued in the session
    [Arguments]    ${in_Config}    ${in_EnqueueData}
    Log    Send Success Message

Email Users Error Message
    [Documentation]    Inform users of error in the session
    [Arguments]    ${in_Config}    ${in_ErrorMessage}
    Log    Send Error Message
