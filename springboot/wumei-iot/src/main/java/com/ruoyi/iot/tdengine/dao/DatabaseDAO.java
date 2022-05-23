package com.ruoyi.iot.tdengine.dao;

import org.springframework.stereotype.Repository;

/**
 * @package com.ruoyi.mysql.mysql.tdengine
 * 类名: DatabaseMapper
 * 描述: TODO
 * 时间: 2022/5/16,0016 1:27
 * 开发人: wxy
 */
@Repository
public interface DatabaseDAO {

    int  createDB();

    int  dropDatabase();

    int  useDatabase();

    int  createTable();



}
