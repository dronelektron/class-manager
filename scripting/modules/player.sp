ArrayList Player_GetByTeamAndClass(int team, int class) {
    ArrayList players = new ArrayList();

    for (int client = 1; client <= MaxClients; client++) {
        if (!IsClientInGame(client)) {
            continue;
        }

        int playerTeam = GetClientTeam(client);
        int playerClass = Player_GetClass(client);

        if (playerTeam == team && playerClass == class) {
            players.Push(client);
        }
    }

    return players;
}

int Player_GetClass(int client) {
    return GetEntProp(client, Prop_Send, "m_iDesiredPlayerClass");
}
