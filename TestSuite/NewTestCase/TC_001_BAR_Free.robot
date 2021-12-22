*** Settings ***
Resource    ../../TestCase/SignUpandLogin/BAR.robot

*** Test Cases ***
BAR free
    initialize
    BAR with no cost signup
    teardown