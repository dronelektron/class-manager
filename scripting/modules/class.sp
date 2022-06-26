static char g_classNames[][] = {RIFLEMAN, ASSAULT, SUPPORT, SNIPER, MG, ROCKET};

void Class_GetName(int class, char[] className) {
    strcopy(className, CLASS_NAME_SIZE, g_classNames[class]);
}
