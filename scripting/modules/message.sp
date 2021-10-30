void NotifyAboutClassLimitChange(int client, int team, int class, int limit) {
    ShowActivity2(client, PREFIX, "%t", "Class limit was changed", classNames[class], teamNames[team - 2], limit);
    LogAction(client, -1, "\"%L\" changed class limit of '%s' in team '%s' to '%d'", client, classNames[class], teamNames[team - 2], limit);
}

void NotifyAboutSpectatorTeam(int client) {
    PrintToChat(client, "%s%t", PREFIX, "You was moved to spectator team");
}
