*** Settings ***
Documentation  Handling various browsers
Library  Selenium2Library
Library  Selenium2LibraryExtensions
Library  OperatingSystem
Library  Collections
Test Timeout  2 minutes
Suite Set Up     Setup webdrivers
Suite Tear Down  Close opened browsers


*** Variables ***
${url_google}			https://www.google.com/
${local_ie_driver64}	G:\\IEDriverServer_x64_2.53.1\\IEDriverServer.exe
${local_ie_driver32}	G:\\IEDriverServer_Win32_2.53.1\\IEDriverServer.exe
${firefox}				C:\\Program Files\\Mozilla Firefox\\firefox.exe
${custom-browser}		
${search-term}			macarronada
${delay}				2


*** Test Cases ***
IE Interaction Test 
    Open Browser    ${url_google}    ie
    Wait Until Page Contains    Google
    Input Text    id=lst-ib    ${search-term}
    Click Button    name=btnK
    Wait Until Page Contains    ${search-term}
    Log		${search-term} Found
    Close Browser


Firefox Interaction Test
   [Documentation]  Firefox handling
   [Tags]  Smoke
   
	Log   Opening Firefox
	${ff default caps}    Evaluate    sys.modules['selenium.webdriver'].common.desired_capabilities.DesiredCapabilities.FIREFOX    sys,selenium.webdriver
    Set To Dictionary    ${ff default caps}    marionette=${True}
    Create Webdriver    Firefox    firefox_binary=${firefox}    executable_path=${EXECDIR}\\resources\\geckodriver.exe
    Go To    https://stackoverflow.com
    Title Should Be    Stack Overflow - Where Developers Learn, Share, &amp; Build Careers    
    Sleep    2 s
    
    [Teardown]    Close Browser
    
   
*** Keywords ***
Setup webdrivers
	Set Environment Variable    no_proxy    127.0.0.1
    Set Environment Variable    webdriver.ie.driver    ${local_ie_driver32}
Close opened browsers
	Close All Browsers
Folder
	[Arguments]    ${path}=${EXECDIR}\\resources\\
    Directory Should Exist    ${path}