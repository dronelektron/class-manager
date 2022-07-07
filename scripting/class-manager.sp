#include <sourcemod>
#undef REQUIRE_PLUGIN
#include <adminmenu>

#pragma semicolon 1
#pragma newdecls required

#include "cm/class"
#include "cm/menu"
#include "cm/message"
#include "cm/team"

#include "modules/class.sp"
#include "modules/console-variable.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/player.sp"
#include "modules/team.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Class manager",
    author = "Dron-elektron",
    description = "Allows you to perform various operations on player classes",
    version = "1.0.1",
    url = "https://github.com/dronelektron/class-manager"
};

public void OnPluginStart() {
    Variable_FindClassLimits();
    AdminMenu_Create();
    LoadTranslations("class-manager.phrases");
}

public void OnLibraryRemoved(const char[] name) {
    if (strcmp(name, ADMIN_MENU) == 0) {
        AdminMenu_Destroy();
    }
}

public void OnAdminMenuReady(Handle topMenu) {
    AdminMenu_OnReady(topMenu);
}
