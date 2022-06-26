static char g_teamNames[][] = {ALLIES, AXIS};

void Team_GetName(int team, char[] teamName) {
    strcopy(teamName, TEAM_NAME_SIZE, g_teamNames[team]);
}
