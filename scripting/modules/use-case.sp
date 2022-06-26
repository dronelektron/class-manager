void UseCase_ChangeClassLimit(int client, int team, int class, int limit) {
    Variable_SetClassLimit(team, class, limit);
    Message_ClassLimitChanged(client, team, class, limit);
}

void UseCase_MoveToSpectator(int team, int class, int limit) {
    if (limit == -1) {
        return;
    }

    ArrayList players = Player_GetByTeamAndClass(team, class);

    for (int i = limit; i < players.Length; i++) {
        int client = players.Get(i);

        ChangeClientTeam(client, Team_Spectator);
        MessagePrint_YouWasMovedToSpectators(client);
    }

    delete players;
}
