void Message_ClassLimitChanged(int client, int team, int class, int limit) {
    char teamName[TEAM_NAME_SIZE];
    char className[CLASS_NAME_SIZE];

    Team_GetName(team - 2, teamName);
    Class_GetName(class, className);
    MessageActivity_ClassLimitChanged(client, teamName, className, limit);
    MessageLog_ClassLimitChanged(client, teamName, className, limit);
}

void MessageActivity_ClassLimitChanged(int client, const char[] teamName, const char[] className, int limit) {
    ShowActivity2(client, PREFIX, "%t", "Class limit was changed", className, teamName, limit);
}

void MessageLog_ClassLimitChanged(int client, const char[] teamName, const char[] className, int limit) {
    LogAction(client, -1, "\"%L\" changed class limit of '%s' in team '%s' to '%d'", client, className, teamName, limit);
}

void MessagePrint_YouWasMovedToSpectators(int client) {
    PrintToChat(client, "%s%t", PREFIX, "You was moved to spectator team");
}
