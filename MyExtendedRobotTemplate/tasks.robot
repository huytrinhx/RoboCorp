*** Settings ***
Documentation       Template robot main suite.

Library             Collections
Library             MyLibrary
Resource            keywords.robot
Variables           MyVariables.py


*** Tasks ***
Main
    # Log    ${MYURL}
    # Launch My GitHub
    # Call Weather Api    ${MyLocation}
    Do String Operations    My Name is Ashev Lev