static TopMenuObject g_classManagerCategory = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemAlliesTeam = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemAxisTeam = INVALID_TOPMENUOBJECT;

static int g_selectedTeam[MAXPLAYERS + 1] = {Team_Unassigned, ...};
static int g_selectedClass[MAXPLAYERS + 1] = {Class_Unknown, ...};

void AddClassManagerToAdminMenu() {
    g_classManagerCategory = g_adminMenu.AddCategory(CLASS_MANAGER, TopMenuHandler_ClassManager);

    if (g_classManagerCategory != INVALID_TOPMENUOBJECT) {
        g_menuItemAlliesTeam = g_adminMenu.AddItem(ALLIES, TopMenuHandler_ClassManager, g_classManagerCategory);
        g_menuItemAxisTeam = g_adminMenu.AddItem(AXIS, TopMenuHandler_ClassManager, g_classManagerCategory);
    }
}

public void TopMenuHandler_ClassManager(TopMenu topmenu, TopMenuAction action, TopMenuObject topobj_id, int param, char[] buffer, int maxlength) {
    if (action == TopMenuAction_DisplayOption) {
        if (topobj_id == g_classManagerCategory) {
            Format(buffer, maxlength, "%T", CLASS_MANAGER, param);
        } else if (topobj_id == g_menuItemAlliesTeam) {
            Format(buffer, maxlength, "%T", ALLIES, param);
        } else if (topobj_id == g_menuItemAxisTeam) {
            Format(buffer, maxlength, "%T", AXIS, param);
        }
    } else if (action == TopMenuAction_DisplayTitle) {
        if (topobj_id == g_classManagerCategory) {
            Format(buffer, maxlength, "%T", CLASS_MANAGER, param);
        }
    } else if (action == TopMenuAction_SelectOption) {
        if (topobj_id == g_menuItemAlliesTeam) {
            g_selectedTeam[param] = Team_Allies;

            CreateClassMenu(param);
        } else if (topobj_id == g_menuItemAxisTeam) {
            g_selectedTeam[param] = Team_Axis;

            CreateClassMenu(param);
        }
    }
}

void CreateClassMenu(int client) {
    Menu menu = new Menu(MenuHandler_Class);

    AddTranslatedMenuItem(menu, RIFLEMAN, RIFLEMAN, client);
    AddTranslatedMenuItem(menu, ASSAULT, ASSAULT, client);
    AddTranslatedMenuItem(menu, SUPPORT, SUPPORT, client);
    AddTranslatedMenuItem(menu, SNIPER, SNIPER, client);
    AddTranslatedMenuItem(menu, MG, MG, client);
    AddTranslatedMenuItem(menu, ROCKET, ROCKET, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

int MenuHandler_Class(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[TEXT_BUFFER_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, RIFLEMAN)) {
            g_selectedClass[param1] = Class_Rifleman;
        } else if (StrEqual(info, ASSAULT)) {
            g_selectedClass[param1] = Class_Assault;
        } else if (StrEqual(info, SUPPORT)) {
            g_selectedClass[param1] = Class_Support;
        } else if (StrEqual(info, SNIPER)) {
            g_selectedClass[param1] = Class_Sniper;
        } else if (StrEqual(info, MG)) {
            g_selectedClass[param1] = Class_Mg;
        } else if (StrEqual(info, ROCKET)) {
            g_selectedClass[param1] = Class_Rocket;
        }

        CreateClassActionMenu(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void CreateClassActionMenu(int client) {
    Menu menu = new Menu(MenuHandler_ClassAction);

    AddTranslatedMenuItem(menu, "-1", ENABLE_CLASS, client);
    AddTranslatedMenuItem(menu, "0", DISABLE_CLASS, client);

    char info[TEXT_BUFFER_MAX_SIZE];

    for (int i = 1; i <= MaxClients; i++) {
        IntToString(i, info, sizeof(info));
        AddTranslatedMenuItem(menu, info, SET_CLASS_LIMIT, client, i);
    }

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

int MenuHandler_ClassAction(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[TEXT_BUFFER_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int team = g_selectedTeam[param1];
        int class = g_selectedClass[param1];

        SetConVarValue(team, class, info);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void MenuHandler_Default(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_End) {
        delete menu;
    } else if (action == MenuAction_Cancel) {
        if (param2 == MenuCancel_ExitBack && g_adminMenu != null) {
            g_adminMenu.Display(param1, TopMenuPosition_LastCategory);
        }
    }
}

void AddTranslatedMenuItem(Menu menu, char[] info, any ...) {
    char item[TEXT_BUFFER_MAX_SIZE];

    VFormat(item, sizeof(item), "%T", 3);

    menu.AddItem(info, item);
}
