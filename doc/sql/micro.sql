DROP DATABASE IF EXISTS `micro`;

CREATE DATABASE  `micro` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
use micro ;

-- ----------------------------
-- 1、部门表
-- ----------------------------
DROP table IF EXISTS `order_info`;
CREATE TABLE order_info (
    oid INT COMMENT '订单ID',
    uid INT COMMENT '用户ID',
    product_name VARCHAR(255) COMMENT '产品名称'
) engine=innodb auto_increment=200 comment = '订单表';

-- ----------------------------
-- 初始化-部门表数据
-- ----------------------------

-- ----------------------------
-- 2、用户信息表
-- ----------------------------
drop table if exists user;
CREATE TABLE user (
      id INT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
      username VARCHAR(255) COMMENT '用户名',
      email VARCHAR(255) COMMENT '电子邮件',
      gender BOOLEAN COMMENT '性别'
) engine=innodb auto_increment=100 comment = '用户信息表';

-- ----------------------------
-- 初始化-用户信息表数据
-- ----------------------------

