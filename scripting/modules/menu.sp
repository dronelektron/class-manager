static TopMenuObject g_classManagerCategory = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemClasses[Class_Rocket + 1] = {INVALID_TOPMENUOBJECT, ...};

static int g_selectedClass[MAXPLAYERS + 1] = {Class_Unknown, ...};
static int g_selectedLimit[MAXPLAYERS + 1] = {-1, ...};

static char teamNames[][] = {ALLIES, AXIS};
static char classNames[][] = {RIFLEMAN, ASSAULT, SUPPORT, SNIPER, MG, ROCKET};

void AddClassManagerToAdminMenu() {
    g_classManagerCategory = g_adminMenu.AddCategory(CLASS_MANAGER, TopMenuHandler_ClassManager);

    if (g_classManagerCategory == INVALID_TOPMENUOBJECT) {
        return;
    }

    for (int class = Class_Rifleman; class <= Class_Rocket; class++) {
        g_menuItemClasses[class] = g_adminMenu.AddItem(classNames[class], TopMenuHandler_ClassManager, g_classManagerCategory);
    }
}

public void TopMenuHandler_ClassManager(TopMenu topmenu, TopMenuAction action, TopMenuObject topobj_id, int param, char[] buffer, int maxlength) {
    if (action == TopMenuAction_DisplayOption) {
        if (topobj_id == g_classManagerCategory) {
            Format(buffer, maxlength, "%T", CLASS_MANAGER, param);

            return;
        }

        for (int class = Class_Rifleman; class <= Class_Rocket; class++) {
            if (topobj_id == g_menuItemClasses[class]) {
                Format(buffer, maxlength, "%T", classNames[class], param);

                break;
            }
        }
    } else if (action == TopMenuAction_DisplayTitle) {
        if (topobj_id == g_classManagerCategory) {
            Format(buffer, maxlength, "%T", CLASS_MANAGER, param);
        }
    } else if (action == TopMenuAction_SelectOption) {
        for (int class = Class_Rifleman; class <= Class_Rocket; class++) {
            if (topobj_id == g_menuItemClasses[class]) {
                g_selectedClass[param] = class;
                CreateClassActionMenu(param);

                break;
            }
        }
    }
}

void CreateClassActionMenu(int client) {
    Menu menu = new Menu(MenuHandler_ClassAction);

    menu.SetTitle("%T", SELECT_ACTION, client);

    AddTranslatedMenuItem(menu, ENABLE_CLASS, ENABLE_CLASS, client);
    AddTranslatedMenuItem(menu, DISABLE_CLASS, DISABLE_CLASS, client);
    AddTranslatedMenuItem(menu, SET_CLASS_LIMIT, SET_CLASS_LIMIT, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

int MenuHandler_ClassAction(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[TEXT_BUFFER_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, ENABLE_CLASS)) {
            g_selectedLimit[param1] = -1;

            CreateTeamMenu(param1);
        } else if (StrEqual(info, DISABLE_CLASS)) {
            g_selectedLimit[param1] = 0;

            CreateTeamMenu(param1);
        } else if (StrEqual(info, SET_CLASS_LIMIT)) {
            CreateClassLimitMenu(param1);
        }
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void CreateClassLimitMenu(int client) {
    Menu menu = new Menu(MenuHandler_ClassLimit);
    char info[TEXT_BUFFER_MAX_SIZE];

    menu.SetTitle("%T", SET_CLASS_LIMIT, client);

    for (int i = 1; i <= MaxClients; i++) {
        IntToString(i, info, sizeof(info));

        menu.AddItem(info, info);
    }

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

int MenuHandler_ClassLimit(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[TEXT_BUFFER_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));
        g_selectedLimit[param1] = StringToInt(info);

        CreateTeamMenu(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void CreateTeamMenu(int client) {
    Menu menu = new Menu(MenuHandler_TeamAction);

    menu.SetTitle("%T", "Select team", client);

    AddTranslatedMenuItem(menu, ALLIES, ALLIES, client);
    AddTranslatedMenuItem(menu, AXIS, AXIS, client);
    AddTranslatedMenuItem(menu, BOTH_TEAMS, BOTH_TEAMS, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

int MenuHandler_TeamAction(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[TEXT_BUFFER_MAX_SIZE];
        int class = g_selectedClass[param1];
        int limit = g_selectedLimit[param1];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, ALLIES)) {
            SetConVarValue(Team_Allies, class, limit);
        } else if (StrEqual(info, AXIS)) {
            SetConVarValue(Team_Axis, class, limit);
        } else if (StrEqual(info, BOTH_TEAMS)) {
            SetConVarValue(Team_Allies, class, limit);
            SetConVarValue(Team_Axis, class, limit);
        }
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
