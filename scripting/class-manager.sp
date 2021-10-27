#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#include "class"
#include "team"
#include "message"

public Plugin myinfo = {
    name = "Class manager",
    author = "Dron-elektron",
    description = "Allows you to perform various operations on player classes",
    version = "0.1.0",
    url = ""
}

public void OnPluginStart() {
    FindClassLimitConVars();
    LoadTranslations("class-manager.phrases");
}
