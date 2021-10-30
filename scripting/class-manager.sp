#include <sourcemod>
#undef REQUIRE_PLUGIN
#include <adminmenu>

#pragma semicolon 1
#pragma newdecls required

#include "class"
#include "team"
#include "message"
#include "menu"

public Plugin myinfo = {
    name = "Class manager",
    author = "Dron-elektron",
    description = "Allows you to perform various operations on player classes",
    version = "0.1.1",
    url = ""
}

char ADMIN_MENU[] = "adminmenu";
TopMenu g_adminMenu = null;

public void OnPluginStart() {
    FindClassLimitConVars();
    LoadTranslations("class-manager.phrases");

    TopMenu topMenu;

    if (LibraryExists(ADMIN_MENU) && (topMenu = GetAdminTopMenu()) != null) {
        OnAdminMenuReady(topMenu);
    }
}

public void OnLibraryRemoved(const char[] name) {
    if (StrEqual(name, ADMIN_MENU, false)) {
        g_adminMenu = null;
    }
}

public void OnAdminMenuReady(Handle aTopMenu) {
    TopMenu topMenu = TopMenu.FromHandle(aTopMenu);

    if (topMenu == g_adminMenu) {
        return;
    }

    g_adminMenu = topMenu;

    AddClassManagerToAdminMenu();
}
