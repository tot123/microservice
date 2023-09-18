
CREATE DATABASE  `nacos_config` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE  `seata_server` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

/*   这里表示创建一个不限制ip登录的用户 nacos  该用户的密码是 nacos  %代表不限制ip登录 */
create user 'nacos'@'%' identified by 'nacos';
/*  给用户nacos赋予nacos_config 中所有表的所有权限 with grant option表示该用户可以给其他用户赋权，但是不能超过该用户的权限*/
grant all privileges on nacos_config.* to 'nacos'@'%' with grant option;
/*   这里表示创建一个不限制ip登录的用户 nacos  该用户的密码是 nacos  %代表不限制ip登录 */
create user 'seata'@'%' identified by 'seata';
/*  给用户nacos赋予nacos_config 中所有表的所有权限 with grant option表示该用户可以给其他用户赋权，但是不能超过该用户的权限*/
grant all privileges on seata_server.* to 'seata'@'%' with grant option;
/*   刷新权限   */
flush privileges;


use nacos_config;


/*
 * Copyright 1999-2018 Alibaba Group Holding Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info   */
/******************************************/
CREATE TABLE `config_info`
(
    `id`                 bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `data_id`            varchar(255) NOT NULL COMMENT 'data_id',
    `group_id`           varchar(128)          DEFAULT NULL,
    `content`            longtext     NOT NULL COMMENT 'content',
    `md5`                varchar(32)           DEFAULT NULL COMMENT 'md5',
    `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `src_user`           text COMMENT 'source user',
    `src_ip`             varchar(50)           DEFAULT NULL COMMENT 'source ip',
    `app_name`           varchar(128)          DEFAULT NULL,
    `tenant_id`          varchar(128)          DEFAULT '' COMMENT '租户字段',
    `c_desc`             varchar(256)          DEFAULT NULL,
    `c_use`              varchar(64)           DEFAULT NULL,
    `effect`             varchar(64)           DEFAULT NULL,
    `type`               varchar(64)           DEFAULT NULL,
    `c_schema`           text,
    `encrypted_data_key` text         NOT NULL COMMENT '秘钥',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_aggr   */
/******************************************/
CREATE TABLE `config_info_aggr`
(
    `id`           bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `data_id`      varchar(255) NOT NULL COMMENT 'data_id',
    `group_id`     varchar(128) NOT NULL COMMENT 'group_id',
    `datum_id`     varchar(255) NOT NULL COMMENT 'datum_id',
    `content`      longtext     NOT NULL COMMENT '内容',
    `gmt_modified` datetime     NOT NULL COMMENT '修改时间',
    `app_name`     varchar(128) DEFAULT NULL,
    `tenant_id`    varchar(128) DEFAULT '' COMMENT '租户字段',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增加租户字段';


/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_beta   */
/******************************************/
CREATE TABLE `config_info_beta`
(
    `id`                 bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `data_id`            varchar(255) NOT NULL COMMENT 'data_id',
    `group_id`           varchar(128) NOT NULL COMMENT 'group_id',
    `app_name`           varchar(128)          DEFAULT NULL COMMENT 'app_name',
    `content`            longtext     NOT NULL COMMENT 'content',
    `beta_ips`           varchar(1024)         DEFAULT NULL COMMENT 'betaIps',
    `md5`                varchar(32)           DEFAULT NULL COMMENT 'md5',
    `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `src_user`           text COMMENT 'source user',
    `src_ip`             varchar(50)           DEFAULT NULL COMMENT 'source ip',
    `tenant_id`          varchar(128)          DEFAULT '' COMMENT '租户字段',
    `encrypted_data_key` text         NOT NULL COMMENT '秘钥',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_beta';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_tag   */
/******************************************/
CREATE TABLE `config_info_tag`
(
    `id`           bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `data_id`      varchar(255) NOT NULL COMMENT 'data_id',
    `group_id`     varchar(128) NOT NULL COMMENT 'group_id',
    `tenant_id`    varchar(128)          DEFAULT '' COMMENT 'tenant_id',
    `tag_id`       varchar(128) NOT NULL COMMENT 'tag_id',
    `app_name`     varchar(128)          DEFAULT NULL COMMENT 'app_name',
    `content`      longtext     NOT NULL COMMENT 'content',
    `md5`          varchar(32)           DEFAULT NULL COMMENT 'md5',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `src_user`     text COMMENT 'source user',
    `src_ip`       varchar(50)           DEFAULT NULL COMMENT 'source ip',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_tag';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_tags_relation   */
/******************************************/
CREATE TABLE `config_tags_relation`
(
    `id`        bigint(20) NOT NULL COMMENT 'id',
    `tag_name`  varchar(128) NOT NULL COMMENT 'tag_name',
    `tag_type`  varchar(64)  DEFAULT NULL COMMENT 'tag_type',
    `data_id`   varchar(255) NOT NULL COMMENT 'data_id',
    `group_id`  varchar(128) NOT NULL COMMENT 'group_id',
    `tenant_id` varchar(128) DEFAULT '' COMMENT 'tenant_id',
    `nid`       bigint(20) NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`nid`),
    UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
    KEY         `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_tag_relation';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = group_capacity   */
/******************************************/
CREATE TABLE `group_capacity`
(
    `id`                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `group_id`          varchar(128) NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
    `quota`             int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
    `usage`             int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
    `max_size`          int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
    `max_aggr_count`    int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
    `max_aggr_size`     int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
    `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
    `gmt_create`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = his_config_info   */
/******************************************/
CREATE TABLE `his_config_info`
(
    `id`                 bigint(20) unsigned NOT NULL,
    `nid`                bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `data_id`            varchar(255) NOT NULL,
    `group_id`           varchar(128) NOT NULL,
    `app_name`           varchar(128)          DEFAULT NULL COMMENT 'app_name',
    `content`            longtext     NOT NULL,
    `md5`                varchar(32)           DEFAULT NULL,
    `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `src_user`           text,
    `src_ip`             varchar(50)           DEFAULT NULL,
    `op_type`            char(10)              DEFAULT NULL,
    `tenant_id`          varchar(128)          DEFAULT '' COMMENT '租户字段',
    `encrypted_data_key` text         NOT NULL COMMENT '秘钥',
    PRIMARY KEY (`nid`),
    KEY                  `idx_gmt_create` (`gmt_create`),
    KEY                  `idx_gmt_modified` (`gmt_modified`),
    KEY                  `idx_did` (`data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多租户改造';


/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = tenant_capacity   */
/******************************************/
CREATE TABLE `tenant_capacity`
(
    `id`                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `tenant_id`         varchar(128) NOT NULL DEFAULT '' COMMENT 'Tenant ID',
    `quota`             int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
    `usage`             int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
    `max_size`          int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
    `max_aggr_count`    int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
    `max_aggr_size`     int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
    `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
    `gmt_create`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='租户容量信息表';


CREATE TABLE `tenant_info`
(
    `id`            bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `kp`            varchar(128) NOT NULL COMMENT 'kp',
    `tenant_id`     varchar(128) default '' COMMENT 'tenant_id',
    `tenant_name`   varchar(128) default '' COMMENT 'tenant_name',
    `tenant_desc`   varchar(256) DEFAULT NULL COMMENT 'tenant_desc',
    `create_source` varchar(32)  DEFAULT NULL COMMENT 'create_source',
    `gmt_create`    bigint(20) NOT NULL COMMENT '创建时间',
    `gmt_modified`  bigint(20) NOT NULL COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
    KEY             `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tenant_info';

CREATE TABLE `users`
(
    `username` varchar(50)  NOT NULL PRIMARY KEY,
    `password` varchar(500) NOT NULL,
    `enabled`  boolean      NOT NULL
);

CREATE TABLE `roles`
(
    `username` varchar(50) NOT NULL,
    `role`     varchar(50) NOT NULL,
    UNIQUE INDEX `idx_user_role` (`username` ASC, `role` ASC) USING BTREE
);

CREATE TABLE `permissions`
(
    `role`     varchar(50)  NOT NULL,
    `resource` varchar(255) NOT NULL,
    `action`   varchar(8)   NOT NULL,
    UNIQUE INDEX `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
);

INSERT INTO users (username, password, enabled)
VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', TRUE);

INSERT INTO roles (username, role)
VALUES ('nacos', 'ROLE_ADMIN');

INSERT INTO `config_info`(`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (1, 'seataServer.properties', 'DEFAULT_GROUP', 'store.mode=db\r\n#-----db-----\r\nstore.db.datasource=druid\r\nstore.db.dbType=mysql\r\n# 需要根据mysql的版本调整driverClassName\r\n# mysql8及以上版本对应的driver：com.mysql.cj.jdbc.Driver\r\n# mysql8以下版本的driver：com.mysql.jdbc.Driver\r\nstore.db.driverClassName=com.mysql.cj.jdbc.Driver\r\nstore.db.url=jdbc:mysql://mysql8:3306/seata-server?useUnicode=true&characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useSSL=false\r\nstore.db.user= seata\r\nstore.db.password=seata\r\n# 数据库初始连接数\r\nstore.db.minConn=1\r\n# 数据库最大连接数\r\nstore.db.maxConn=20\r\n# 获取连接时最大等待时间 默认5000，单位毫秒\r\nstore.db.maxWait=5000\r\n# 全局事务表名 默认global_table\r\nstore.db.globalTable=global_table\r\n# 分支事务表名 默认branch_table\r\nstore.db.branchTable=branch_table\r\n# 全局锁表名 默认lock_table\r\nstore.db.lockTable=lock_table\r\n# 查询全局事务一次的最大条数 默认100\r\nstore.db.queryLimit=100\r\n\r\n\r\n# undo保留天数 默认7天,log_status=1（附录3）和未正常清理的undo\r\nserver.undo.logSaveDays=7\r\n# undo清理线程间隔时间 默认86400000，单位毫秒\r\nserver.undo.logDeletePeriod=86400000\r\n# 二阶段提交重试超时时长 单位ms,s,m,h,d,对应毫秒,秒,分,小时,天,默认毫秒。默认值-1表示无限重试\r\n# 公式: timeout>=now-globalTransactionBeginTime,true表示超时则不再重试\r\n# 注: 达到超时时间后将不会做任何重试,有数据不一致风险,除非业务自行可校准数据,否者慎用\r\nserver.maxCommitRetryTimeout=-1\r\n# 二阶段回滚重试超时时长\r\nserver.maxRollbackRetryTimeout=-1\r\n# 二阶段提交未完成状态全局事务重试提交线程间隔时间 默认1000，单位毫秒\r\nserver.recovery.committingRetryPeriod=1000\r\n# 二阶段异步提交状态重试提交线程间隔时间 默认1000，单位毫秒\r\nserver.recovery.asynCommittingRetryPeriod=1000\r\n# 二阶段回滚状态重试回滚线程间隔时间  默认1000，单位毫秒\r\nserver.recovery.rollbackingRetryPeriod=1000\r\n# 超时状态检测重试线程间隔时间 默认1000，单位毫秒，检测出超时将全局事务置入回滚会话管理器\r\nserver.recovery.timeoutRetryPeriod=1000', 'eb0e6c6476f46793c0e26e8cf12f6014', '2023-01-13 06:41:26', '2023-01-13 06:41:26', NULL, '192.168.1.9', '', 'dev-seata', NULL, NULL, NULL, 'properties', NULL, '');
INSERT INTO `his_config_info`(`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`) VALUES (0, 1, 'seataServer.properties', 'DEFAULT_GROUP', '', 'store.mode=db\r\n#-----db-----\r\nstore.db.datasource=druid\r\nstore.db.dbType=mysql\r\n# 需要根据mysql的版本调整driverClassName\r\n# mysql8及以上版本对应的driver：com.mysql.cj.jdbc.Driver\r\n# mysql8以下版本的driver：com.mysql.jdbc.Driver\r\nstore.db.driverClassName=com.mysql.cj.jdbc.Driver\r\nstore.db.url=jdbc:mysql://mysql8:3306/seata-server?useUnicode=true&characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useSSL=false\r\nstore.db.user= seata\r\nstore.db.password=seata\r\n# 数据库初始连接数\r\nstore.db.minConn=1\r\n# 数据库最大连接数\r\nstore.db.maxConn=20\r\n# 获取连接时最大等待时间 默认5000，单位毫秒\r\nstore.db.maxWait=5000\r\n# 全局事务表名 默认global_table\r\nstore.db.globalTable=global_table\r\n# 分支事务表名 默认branch_table\r\nstore.db.branchTable=branch_table\r\n# 全局锁表名 默认lock_table\r\nstore.db.lockTable=lock_table\r\n# 查询全局事务一次的最大条数 默认100\r\nstore.db.queryLimit=100\r\n\r\n\r\n# undo保留天数 默认7天,log_status=1（附录3）和未正常清理的undo\r\nserver.undo.logSaveDays=7\r\n# undo清理线程间隔时间 默认86400000，单位毫秒\r\nserver.undo.logDeletePeriod=86400000\r\n# 二阶段提交重试超时时长 单位ms,s,m,h,d,对应毫秒,秒,分,小时,天,默认毫秒。默认值-1表示无限重试\r\n# 公式: timeout>=now-globalTransactionBeginTime,true表示超时则不再重试\r\n# 注: 达到超时时间后将不会做任何重试,有数据不一致风险,除非业务自行可校准数据,否者慎用\r\nserver.maxCommitRetryTimeout=-1\r\n# 二阶段回滚重试超时时长\r\nserver.maxRollbackRetryTimeout=-1\r\n# 二阶段提交未完成状态全局事务重试提交线程间隔时间 默认1000，单位毫秒\r\nserver.recovery.committingRetryPeriod=1000\r\n# 二阶段异步提交状态重试提交线程间隔时间 默认1000，单位毫秒\r\nserver.recovery.asynCommittingRetryPeriod=1000\r\n# 二阶段回滚状态重试回滚线程间隔时间  默认1000，单位毫秒\r\nserver.recovery.rollbackingRetryPeriod=1000\r\n# 超时状态检测重试线程间隔时间 默认1000，单位毫秒，检测出超时将全局事务置入回滚会话管理器\r\nserver.recovery.timeoutRetryPeriod=1000', 'eb0e6c6476f46793c0e26e8cf12f6014', '2023-01-13 14:41:26', '2023-01-13 06:41:26', NULL, '192.168.1.9', 'I', 'dev-seata', '');
INSERT INTO `permissions`(`role`, `resource`, `action`) VALUES ('seata', 'dev-seata:*:*', 'rw');
INSERT INTO `roles`(`username`, `role`) VALUES ('seata', 'seata');
INSERT INTO `tenant_info`(`id`, `kp`, `tenant_id`, `tenant_name`, `tenant_desc`, `create_source`, `gmt_create`, `gmt_modified`) VALUES (1, '1', 'dev-seata', 'dev-seata', 'dev-seata', 'nacos', 1673591910955, 1673591910955);
INSERT INTO `users`(`username`, `password`, `enabled`) VALUES ('seata', '$2a$10$dxCeNClGzwGVo0NDs5XgnuGXVY371Xwlw6OkIl2VsNr/6Ki2ww82K', 1);



/*   seata_server */
use seata_server;

-- -------------------------------- The script used when storeMode is 'db' --------------------------------
-- the table to store GlobalSession data
CREATE TABLE IF NOT EXISTS `global_table`
(
    `xid`                       VARCHAR(128) NOT NULL,
    `transaction_id`            BIGINT,
    `status`                    TINYINT      NOT NULL,
    `application_id`            VARCHAR(32),
    `transaction_service_group` VARCHAR(32),
    `transaction_name`          VARCHAR(128),
    `timeout`                   INT,
    `begin_time`                BIGINT,
    `application_data`          VARCHAR(2000),
    `gmt_create`                DATETIME,
    `gmt_modified`              DATETIME,
    PRIMARY KEY (`xid`),
    KEY `idx_status_gmt_modified` (`status` , `gmt_modified`),
    KEY `idx_transaction_id` (`transaction_id`)
    ) ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4;

-- the table to store BranchSession data
CREATE TABLE IF NOT EXISTS `branch_table`
(
    `branch_id`         BIGINT       NOT NULL,
    `xid`               VARCHAR(128) NOT NULL,
    `transaction_id`    BIGINT,
    `resource_group_id` VARCHAR(32),
    `resource_id`       VARCHAR(256),
    `branch_type`       VARCHAR(8),
    `status`            TINYINT,
    `client_id`         VARCHAR(64),
    `application_data`  VARCHAR(2000),
    `gmt_create`        DATETIME(6),
    `gmt_modified`      DATETIME(6),
    PRIMARY KEY (`branch_id`),
    KEY `idx_xid` (`xid`)
    ) ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4;

-- the table to store lock data
CREATE TABLE IF NOT EXISTS `lock_table`
(
    `row_key`        VARCHAR(128) NOT NULL,
    `xid`            VARCHAR(128),
    `transaction_id` BIGINT,
    `branch_id`      BIGINT       NOT NULL,
    `resource_id`    VARCHAR(256),
    `table_name`     VARCHAR(32),
    `pk`             VARCHAR(36),
    `status`         TINYINT      NOT NULL DEFAULT '0' COMMENT '0:locked ,1:rollbacking',
    `gmt_create`     DATETIME,
    `gmt_modified`   DATETIME,
    PRIMARY KEY (`row_key`),
    KEY `idx_status` (`status`),
    KEY `idx_branch_id` (`branch_id`),
    KEY `idx_xid` (`xid`)
    ) ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `distributed_lock`
(
    `lock_key`       CHAR(20) NOT NULL,
    `lock_value`     VARCHAR(20) NOT NULL,
    `expire`         BIGINT,
    primary key (`lock_key`)
    ) ENGINE = InnoDB
    DEFAULT CHARSET = utf8mb4;

INSERT INTO `distributed_lock` (lock_key, lock_value, expire) VALUES ('AsyncCommitting', ' ', 0);
INSERT INTO `distributed_lock` (lock_key, lock_value, expire) VALUES ('RetryCommitting', ' ', 0);
INSERT INTO `distributed_lock` (lock_key, lock_value, expire) VALUES ('RetryRollbacking', ' ', 0);
INSERT INTO `distributed_lock` (lock_key, lock_value, expire) VALUES ('TxTimeoutCheck', ' ', 0);

