static char teamNames[][] = {ALLIES, AXIS};
static char classNames[][] = {RIFLEMAN, ASSAULT, SUPPORT, SNIPER, MG, ROCKET};

void NotifyAboutClassLimitChange(int team, int class, int limit) {
    PrintToChatAll("%s%t", PREFIX, "Class limit was changed", classNames[class], teamNames[team - 2], limit);
}

void NotifyAboutSpectatorTeam(int client) {
    PrintToChat(client, "%s%t", PREFIX, "You was moved to spectator team");
}
