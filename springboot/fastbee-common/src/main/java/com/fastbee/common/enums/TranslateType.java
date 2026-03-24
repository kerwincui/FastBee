package com.fastbee.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import static com.fastbee.common.constant.Constants.*;

@Getter
@AllArgsConstructor
public enum TranslateType {

    MENU_TYPE(MENU, "sys_menu_translate", "sys_menu", "menu_id", "menu_name"),
    DICT_DATA_TYPE(DICT_DATA, "sys_dict_data_translate", "sys_dict_data", "dict_code", "dict_label"),
    DICT_TYPE_TYPE(DICT_TYPE, "sys_dict_type_translate", "sys_dict_type", "dict_id", "dict_name"),
    THINGS_MODEL_TYPE(THINGS_MODEL, "iot_things_model_translate", "iot_things_model", "model_id", "model_name"),
    THINGS_MODEL_TEMPLATE_TYPE(THINGS_MODEL_TEMPLATE, "iot_things_model_template_translate", "iot_things_model_template", "template_id", "template_name");

    String value;
    String translateTable;
    String sourceTable;
    String idColumn;
    String nameColumn;

}
