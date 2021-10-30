void NotifyAboutClassLimitChange(int team, int class, int limit) {
    PrintToChatAll("%s%t", PREFIX, "Class limit was changed", classNames[class], teamNames[team - 2], limit);
}

void NotifyAboutSpectatorTeam(int client) {
    PrintToChat(client, "%s%t", PREFIX, "You was moved to spectator team");
}
