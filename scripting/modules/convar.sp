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

        g_limitAlliesConVars[i].AddChangeHook(ConVarChanged_ClassLimit);
        g_limitAxisConVars[i].AddChangeHook(ConVarChanged_ClassLimit);
    }
}

void ConVarChanged_ClassLimit(ConVar conVar, char[] oldValue, char[] newValue) {
    int team;
    int class;
    int limit = StringToInt(newValue);

    GetConVarTeamAndClass(conVar, team, class);
    MovePlayersToSpectator(team, class, limit);
}

void GetConVarTeamAndClass(ConVar conVar, int& team, int& class) {
    team = Team_Unassigned;
    class = Class_Unknown;

    for (int i = Class_Rifleman; i <= Class_Rocket; i++) {
        if (conVar == g_limitAlliesConVars[i]) {
            team = Team_Allies;
            class = i;

            break;
        }

        if (conVar == g_limitAxisConVars[i]) {
            team = Team_Axis;
            class = i;

            break;
        }
    }
}

void SetConVarValue(int team, int class, int limit) {
    if (team == Team_Allies) {
        g_limitAlliesConVars[class].SetInt(limit);
    } else if (team == Team_Axis) {
        g_limitAxisConVars[class].SetInt(limit);
    }
}
