static char g_limitAlliesConVarNames[][] = {
    "mp_limit_allies_rifleman",
    "mp_limit_allies_assault",
    "mp_limit_allies_support",
    "mp_limit_allies_sniper",
    "mp_limit_allies_mg",
    "mp_limit_allies_rocket"
};

static char g_limitAxisConVarNames[][] = {
    "mp_limit_axis_rifleman",
    "mp_limit_axis_assault",
    "mp_limit_axis_support",
    "mp_limit_axis_sniper",
    "mp_limit_axis_mg",
    "mp_limit_axis_rocket"
};

static ConVar g_limitAlliesConVars[Class_Rocket + 1] = {null, ...};
static ConVar g_limitAxisConVars[Class_Rocket + 1] = {null, ...};

void FindClassLimitConVars() {
    for (int i = Class_Rifleman; i <= Class_Rocket; i++) {
        g_limitAlliesConVars[i] = FindConVar(g_limitAlliesConVarNames[i]);
        g_limitAxisConVars[i] = FindConVar(g_limitAxisConVarNames[i]);

        g_limitAlliesConVars[i].AddChangeHook(OnAlliesConVarChanged);
        g_limitAxisConVars[i].AddChangeHook(OnAxisConVarChanged);
    }
}

void OnAlliesConVarChanged(ConVar conVar, char[] oldValue, char[] newValue) {
    int class = GetConVarClass(conVar);

    if (class != Class_Unknown) {
        int limit = StringToInt(newValue);

        MovePlayersToSpectator(Team_Allies, class, limit);
    }
}

void OnAxisConVarChanged(ConVar conVar, char[] oldValue, char[] newValue) {
    int class = GetConVarClass(conVar);

    if (class != Class_Unknown) {
        int limit = StringToInt(newValue);

        MovePlayersToSpectator(Team_Axis, class, limit);
    }
}

int GetConVarClass(ConVar conVar) {
    int class = Class_Unknown;

    for (int i = Class_Rifleman; i <= Class_Rocket; i++) {
        if (conVar == g_limitAlliesConVars[i]) {
            class = i;

            break;
        }
    }

    return class;
}
