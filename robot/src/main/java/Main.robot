*** Settings ***
Documentation  Log in to the test environment
Library  Selenium2Library
Library  OperatingSystem
Library  Collections
Test Timeout  2 minutes
*Suite Set Up     empty
*Suite Tear Down  empty

*** Variables ***
${url_google}     https://fedhr01.econsys.com/frbweb/logon.do?operation=index&client=NPPD
${local_ie_driver64}  G:\\IEDriverServer_x64_2.53.1\\IEDriverServer.exe
${local_ie_driver32}  G:\\IEDriverServer_Win32_2.53.1\\IEDriverServer.exe


*** Test Cases ***
Initialize the environment variables
    Set Environment Variable    no_proxy    127.0.0.1
    Set Environment Variable    webdriver.ie.driver    ${local_ie_driver2}

Open up the agency site
    Open Browser    ${url_google}    ie
    Wait Until Page Contains    Google
    Input Text    id=lst-ib    macarronada
    Click Button    name=btnG
    Wait Until Page Contains    macarronada
    Close Browser

# My Test: Opening a browser window
   [Documentation]  Basic connectivity test
   [Tags]  Smoke
   ${ff default caps}    Evaluate    sys.modules['selenium.webdriver'].common.desired_capabilities.DesiredCapabilities.FIREFOX    sys,selenium.webdriver
    Set To Dictionary    ${ff default caps}    marionette=${True}
    Create Webdriver    Firefox    executable_path=C:\\stuff\\wires.exe
    Go To    https://stackoverflow.com
    Sleep    2 s
    [Teardown]    Close All Browsers
   
*** Keywords ***
