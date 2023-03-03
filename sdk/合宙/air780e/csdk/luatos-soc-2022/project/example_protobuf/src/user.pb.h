#include <pb.h>

#if PB_PROTO_HEADER_VERSION != 30
#error Regenerate this file with the current version of nanopb generator.
#endif


/* Enum definitions */
typedef enum _UserStatus {
    UserStatus_UNKNOWN = 0,
    UserStatus_IDLE = 1,
    UserStatus_BUSY = 2
} UserStatus;
#define _UserStatus_MIN UserStatus_UNKNOWN
#define _UserStatus_MAX UserStatus_BUSY
#define _UserStatus_ARRAYSIZE ((UserStatus)(UserStatus_BUSY+1))

/* Struct definitions */
typedef struct _UserInformation {
    char name[20];
    uint32_t age;
    char phone[16];
    UserStatus stat;
    char email[30];
/* @@protoc_insertion_point(struct:UserInformation) */
} UserInformation;

/* Default values for struct fields */

/* Initializer values for message structs */
#define UserInformation_init_default             {"", 0, "", _UserStatus_MIN, ""}
#define UserInformation_init_zero                {"", 0, "", _UserStatus_MIN, ""}

/* Field tags (for use in manual encoding/decoding) */
#define UserInformation_name_tag                 1
#define UserInformation_age_tag                  2
#define UserInformation_phone_tag                3
#define UserInformation_stat_tag                 4
#define UserInformation_email_tag                5

/* Struct field encoding specification for nanopb */
extern const pb_field_t UserInformation_fields[6];

/* Maximum encoded size of messages (where known) */
#define UserInformation_size                     80

/* Message IDs (where set with "msgid" option) */
#ifdef PB_MSGID

#define USERINFORMATION_MESSAGES \


#endif
