void MovePlayersToSpectator(int team, int class, int limit) {
    if (limit == -1) {
        return;
    }

    ArrayList players = GetPlayersByTeamAndClass(team, class);

    for (int i = limit; i < players.Length; i++) {
        int client = players.Get(i);

        ChangeClientTeam(client, Team_Spectator);
        NotifyAboutSpectatorTeam(client);
    }

    delete players;
}

ArrayList GetPlayersByTeamAndClass(int team, int class) {
    ArrayList players = new ArrayList();

    for (int client = 1; client <= MaxClients; client++) {
        if (!IsClientInGame(client)) {
            continue;
        }

        int playerTeam = GetClientTeam(client);
        int playerClass = GetPlayerClass(client);

        if (playerTeam == team && playerClass == class) {
            players.Push(client);
        }
    }

    return players;
}

int GetPlayerClass(int client) {
    return GetEntProp(client, Prop_Send, "m_iDesiredPlayerClass");
}
