#if defined _class_included
 #endinput
#endif
#define _class_included

#define CLASS_NAME_SIZE 32
#define CLASS_DISABLED 0
#define CLASS_UNLIMITED -1

enum {
    Class_Unknown = -1,
    Class_Rifleman,
    Class_Assault,
    Class_Support,
    Class_Sniper,
    Class_Mg,
    Class_Rocket
};
