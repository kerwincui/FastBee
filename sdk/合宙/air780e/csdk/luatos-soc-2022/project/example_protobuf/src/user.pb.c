#include "user.pb.h"

/* @@protoc_insertion_point(includes) */
#if PB_PROTO_HEADER_VERSION != 30
#error Regenerate this file with the current version of nanopb generator.
#endif



const pb_field_t UserInformation_fields[6] = {
    PB_FIELD(  1, STRING  , SINGULAR, STATIC  , FIRST, UserInformation, name, name, 0),
    PB_FIELD(  2, UINT32  , SINGULAR, STATIC  , OTHER, UserInformation, age, name, 0),
    PB_FIELD(  3, STRING  , SINGULAR, STATIC  , OTHER, UserInformation, phone, age, 0),
    PB_FIELD(  4, UENUM   , SINGULAR, STATIC  , OTHER, UserInformation, stat, phone, 0),
    PB_FIELD(  5, STRING  , SINGULAR, STATIC  , OTHER, UserInformation, email, stat, 0),
    PB_LAST_FIELD
};