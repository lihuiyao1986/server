DROP DATABASE IF EXISTS software;
CREATE DATABASE software;
use software;

DROP TABLE IF EXISTS `T_USER`;
CREATE TABLE `T_USER` (
  `T_ID` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `T_USER_NAME` VARCHAR(255) UNICODE NOT NULL COMMENT '用户名',
  `T_NAME` VARCHAR(255) COMMENT '用户姓名',
  `T_QQ` VARCHAR(50) COMMENT 'QQ号码',
  `T_SEX` CHAR(2) COMMENT '性别',
  `T_WEBCHAT` VARCHAR(50) COMMENT '微信号码',
  `T_BIRTHDAY` DATETIME COMMENT '生日',
  `T_MOBILE` VARCHAR(11) UNIQUE COMMENT '手机号',
  `T_MOBILE_STATUS` CHAR(1) DEFAULT '0' COMMENT '手机号认证状态 0-未认证 1-已认证',
  `T_EMAIL` VARCHAR(255) UNIQUE COMMENT '邮箱',
  `T_EMAIL_STATUS` CHAR(1) DEFAULT '0' COMMENT '邮箱认证状态 0-未认证 1-已认证',
  `T_STATUS` CHAR(2) DEFAULT '00' COMMENT '00-未认证 01-已认证 02-已锁定 03-已删除 04-已拉黑',
  `T_REG_TIME` DATETIME COMMENT '注册时间',
  `T_USER_PROPERTY` CHAR(1) DEFAULT 'C' COMMENT '用户属性 C:端用户 B:端用户 ',
  `T_USER_TYPE` CHAR(1) DEFAULT '0' COMMENT '用户属性 0:个人用户 1:机构用户 ',
  `T_LOGIN_COUNT` INT(20) DEFAULT 0 COMMENT '登录次数',
  `T_LOGIN_TIME` DATETIME COMMENT  '登录时间',
  `T_LAST_LOGIN_TIME` DATETIME COMMENT  '上一次登录时间',
  `T_LOGIN_IP` VARCHAR(255) COMMENT '登录IP',
  `T_LOGIN_DEVICE_ID` BIGINT(20)  COMMENT '登录终端编号',
  `T_PASSWORD` VARCHAR(255) COMMENT '密码',
  `T_SALT` VARCHAR(64) COMMENT '盐',
  `T_AVATAR` VARCHAR(255) COMMENT '头像',
  `T_GRADE` CHAR(2) COMMENT '等级 00-普通会员 01-黄金会员 02-钻石会员 03-皇冠会员'
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT '用户信息表';

DROP TABLE IF EXISTS `T_USER_LOGIN`;
CREATE TABLE `T_USER_LOGIN` (
  `T_ID` BIGINT(20) PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
  `T_LOGIN_TYPE` CHAR(2)  COMMENT '登录类型 00-手机号登录 01-邮箱登录 02-用户名登录',
  `T_LOGIN_NAME` VARCHAR(255) UNIQUE COMMENT '登录用户名',
  `T_USER_ID` BIGINT(20) COMMENT '用户ID'
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT '用户登录信息表';

DROP TABLE IF EXISTS `T_USER_DEVICE`;
CREATE TABLE `T_USER_DEVICE` (
  `T_ID` BIGINT(20) PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
  `T_USER_ID` BIGINT(20)  COMMENT '用户编号',
  `T_DEVICE_INFO` VARCHAR(255) COMMENT '手机信息描述',
  `T_DEVICE_SYS_VERSION` VARCHAR(255) COMMENT '手机系统的版本号',
  `T_SCREEN_HEIGHT` VARCHAR(255) COMMENT '设备的高度',
  `T_SCREEN_WIDTH` VARCHAR(255) COMMENT '设备的宽度',
  `T_UUID` VARCHAR(255) COMMENT '手机唯一标识',
  `T_NET_TYPE` VARCHAR(255) COMMENT '网络类型',
  `T_DEVICE_SYS_TYPE` CHAR(2) COMMENT '手机系统类型 00-android 01-iOS',
  `T_DENSITY` VARCHAR(255) COMMENT '屏幕密度'
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT '用户登录设备信息';

DROP TABLE IF EXISTS `T_RESOURCE`;
CREATE TABLE `T_RESOURCE` (
  `T_ID` BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  `T_RES_NAME` VARCHAR(10) DEFAULT NULL COMMENT '权限名称',
  `T_RES_KEY` VARCHAR(255) UNIQUE COMMENT '权限key',
  `T_RES_VALUE` VARCHAR(300) COMMENT '权限value',
  `T_RES_TYPE` CHAR(2) COMMENT '权限类型 00: url访问权限 01:菜单访问权限',
  `T_RES_STATUS` CHAR(1) COMMENT '权限状态 0:正常 1:已停用'
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT '权限表';

DROP TABLE IF EXISTS `T_ROLE`;
CREATE TABLE `T_ROLE` (
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY COMMENT '主健',
  `T_ROLE_NAME` VARCHAR(200) DEFAULT NULL COMMENT '角色名称',
  `T_ROLE_VALUE` VARCHAR(1000) UNIQUE COMMENT '角色值',
  `T_ROLE_STATUS` CHAR(1) COMMENT '角色状态 0:正常 1:已停用'
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT '角色表';

DROP TABLE IF EXISTS `T_ROLE_RESOURCE`;
CREATE TABLE `T_ROLE_RESOURCE` (
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
  `T_ROLE_ID` BIGINT(20) COMMENT '角色ID',
  `T_RES_ID` BIGINT(20) COMMENT '权限ID'
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT='角色资源表';

DROP TABLE IF EXISTS `T_USER_ROLE`;
CREATE TABLE `T_USER_ROLE` (
  `T_ID` BIGINT(20) PRIMARY KEY AUTO_INCREMENT COMMENT '主健',
  `T_USER_ID` BIGINT(20) COMMENT '用户ID',
  `T_ROLE_ID` BIGINT(20) COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT='用户角色表';


DROP TABLE IF EXISTS `T_DICT`;
CREATE TABLE IF NOT EXISTS `T_DICT` (
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_CODE` VARCHAR(255) COMMENT '字典代码',
  `T_NAME` VARCHAR(255) COMMENT '标签',
  `T_VALUE` VARCHAR(255) COMMENT '字典值',
  `T_DESC` varchar(255) DEFAULT '' COMMENT '字典描述',
  `T_SORT` INT(11) DEFAULT '0' COMMENT '排序',
  `T_REMARK` VARCHAR(255) DEFAULT '' COMMENT '备注',
  `T_DISABLED` CHAR(1) NOT NULL DEFAULT '0' COMMENT '是否启用:0启用,1不启用'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';


/*****论坛数据库设计****/

/****  论坛版块分类  ****/
DROP TABLE IF EXISTS `T_BBS_CATEGORY`;
CREATE TABLE IF NOT EXISTS `T_BBS_CATEGORY`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_NAME` VARCHAR(255) COMMENT '板块名称',
  `T_INTRO` TEXT COMMENT '板块介绍',
  `T_PID` BIGINT(20) COMMENT '父板块的ID',
  `T_RULE` TEXT COMMENT '板块的规则',
  `T_TOPIC_COUNT` BIGINT(20) COMMENT '板块主题总计',
  `T_REPLY_COUNT` BIGINT(20) COMMENT '板块回帖总计',
  `T_LAST_TOPIC_ID` BIGINT(20) COMMENT '板块最后发表回复贴子对应的主题ID',
  `T_CREATOR_ID` BIGINT(20) COMMENT '板块创建者ID',
  `T_CREATOR_TIME` DATETIME COMMENT '板块创建时间',
  `T_ICON` VARCHAR(255) COMMENT '板块对应的ICON',
  `T_URL` VARCHAR(255) COMMENT '板块对应的URL',
  `T_RANK` INT(12) COMMENT '排序',
  `T_ENABLED` CHAR(1) COMMENT '是否启用 0-未启用 1-启用'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛板块分类表';

/****  论坛主题  ****/
DROP TABLE IF EXISTS `T_BBS_TOPIC`;
CREATE TABLE IF NOT EXISTS `T_BBS_TOPIC`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_CATEGORY_ID` VARCHAR(255) NOT NULL  COMMENT '主题对应的板块名ID',
  `T_TITLE` VARCHAR(255) NOT NULL COMMENT '标题',
  `T_CONTENT` TEXT NOT NULL  COMMENT '内容',
  `T_USER_ID` BIGINT(20) NOT NULL COMMENT '发帖人ID',
  `T_HITS`  BIGINT(20) NOT NULL COMMENT '访问总量',
  `T_REPLY_COUNT` BIGINT(20) NOT NULL COMMENT '回复统计',
  `T_LAST_MODIFIER` BIGINT(20) NOT NULL COMMENT '最后的编辑用户',
  `T_LAST_MODIFY_TIME` DATETIME NOT NULL COMMENT '最后的编辑时间',
  `T_LAST_REPLYER` BIGINT(20) NOT NULL COMMENT '最后的回复用户',
  `T_LAST_REPLY_TIME` DATETIME NOT NULL COMMENT '最后的回复时间',
  `T_ICON` VARCHAR(255) NOT NULL  COMMENT '主题的ICON',
  `T_IMG_URL` VARCHAR(255) NOT NULL  COMMENT '帖子展示图片',
  `T_IS_CLOSED` CHAR(1) NOT NULL  COMMENT '是否关闭［关闭贴不给回复］',
  `T_CREATE_TIME` BIGINT(20) NOT NULL  COMMENT '创建时间',
  `T_ENABLED` CHAR(1) NOT NULL COMMENT '是否启用 0-未启用 1-启用'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛主题表';

/****论坛主题状态表****/
DROP TABLE IF EXISTS `T_BBS_TOPIC_STATE`;
CREATE TABLE IF NOT EXISTS `T_BBS_TOPIC_STATE`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_TOPIC_ID` BIGINT(20) NOT NULL  COMMENT '主题ID',
  `T_STATE_ID` BIGINT(20) NOT NULL COMMENT '标题',
  `T_TITLE` VARCHAR(255) NOT NULL  COMMENT '状态标题',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛主题状态表';

/****论坛主题状态类型表****/
DROP TABLE IF EXISTS `T_BBS_TOPIC_STATE_TYPE`;
CREATE TABLE IF NOT EXISTS `T_BBS_TOPIC_STATE_TYPE`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_NAME` VARCHAR(255) NOT NULL  COMMENT '名称',
  `T_KEY` VARCHAR(255) NOT NULL COMMENT '标题',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛主题状态类型表';


/****论坛帖子回复表****/
DROP TABLE IF EXISTS `T_BBS_REPLY`;
CREATE TABLE IF NOT EXISTS `T_BBS_REPLY`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_TOPIC_ID` BIGINT(20) NOT NULL  COMMENT '主题ID',
  `T_CONTENT` BIGINT(20) NOT NULL COMMENT '标题',
  `T_TITLE` VARCHAR(255) NOT NULL  COMMENT '状态标题',
  `T_REPLYER` BIGINT(20) NOT NULL  COMMENT '回贴人',
  `T_MODIFY_TIME` DATETIME NOT NULL  COMMENT '修改时间',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间',
  `T_IS_DELETE` CHAR(1) NOT NULL  COMMENT '是否已删除 0-未删除 1-已删除'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛帖子回复表';

/****论坛投票表****/
DROP TABLE IF EXISTS `T_BBS_VOTE`;
CREATE TABLE IF NOT EXISTS `T_BBS_VOTE`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_TOPIC_ID` BIGINT(20) NOT NULL  COMMENT '主题ID',
  `T_TYPE` CHAR(2) NOT NULL COMMENT '类型 00-单选 01-多选',
  `T_TITLE` VARCHAR(255) NOT NULL  COMMENT '状态标题',
  `T_COUNT` BIGINT(20) NOT NULL  COMMENT '投票总数',
  `T_USER_COUNT` BIGINT(20) NOT NULL  COMMENT '投票的用户数',
  `T_AVAILABLE_DAY` INT NOT NULL  COMMENT '投票有效天数',
  `T_LOOK_LOCK` CHAR(1) NOT NULL  COMMENT '查看方式 0:直接查看 1:投票后查看',
  `T_ENABLED` CHAR(1) NOT NULL COMMENT '是否启用 0-未启用 1-启用',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛投票表';

/****论坛投标帖的投票项表****/
DROP TABLE IF EXISTS `T_BBS_VOTE_ITEM`;
CREATE TABLE IF NOT EXISTS `T_BBS_VOTE_ITEM`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_VOTE_ID` BIGINT(20) NOT NULL  COMMENT '投票ID',
  `T_NAME` VARCHAR(255) NOT NULL COMMENT '投票项目名称',
  `T_COUNT` BIGINT(20) NOT NULL  COMMENT '投票数',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛投标帖的投票项表';

/****论坛投票帖的投票用户****/
DROP TABLE IF EXISTS `T_BBS_VOTE_USER`;
CREATE TABLE IF NOT EXISTS `T_BBS_VOTE_USER`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_VOTE_ID` BIGINT(20) NOT NULL  COMMENT '投票ID',
  `T_VOTE_ITEM_ID` BIGINT(20) NOT NULL COMMENT '投票项目名称',
  `T_USER_ID` BIGINT(20) NOT NULL  COMMENT '投票用户ID',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '投票时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛投票帖的投票用户';

/****论坛投票帖附件表****/
DROP TABLE IF EXISTS `T_BBS_ATTACHMENT`;
CREATE TABLE IF NOT EXISTS `T_BBS_ATTACHMENT`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_TOPIC_ID` BIGINT(20) NOT NULL  COMMENT '主题ID',
  `T_NAME` VARCHAR(255) NOT NULL COMMENT '附件名称',
  `T_FILE_PATH` VARCHAR(255) NOT NULL  COMMENT '附件的路径',
  `T_POINT` BIGINT(20) NOT NULL  COMMENT '下载所需积分',
  `T_DESC` TEXT NOT NULL  COMMENT '附件描述',
  `T_FILE_NAME` VARCHAR(255) NOT NULL  COMMENT '附件名',
  `T_FILE_SIZE` BIGINT(20) NOT NULL  COMMENT '附件大小',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '投票时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛投票帖附件表';

DROP TABLE IF EXISTS `T_INTERFACE_MODULE`;
CREATE TABLE IF NOT EXISTS `T_INTERFACE_MODULE`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_EN_NAME` VARCHAR(255) UNIQUE NOT NULL  COMMENT '接口模块英文名称',
  `T_ZH_NAME` VARCHAR(255) NOT NULL  COMMENT '接口模块中文名称',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口模块表';

DROP TABLE IF EXISTS `T_INTERFACE`;
CREATE TABLE IF NOT EXISTS `T_INTERFACE`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_NAME` VARCHAR(255) COMMENT '接口名称',
  `T_METHOD` VARCHAR(255) COMMENT '请求方法',
  `T_URL` VARCHAR(255) UNIQUE NOT NULL  COMMENT '接口URL',
  `T_MODULE_ID` BIGINT(20) COMMENT '接口所属模块名ID',
  `T_NORMAL_JSON_RESULT` VARCHAR(255) NOT NULL COMMENT '返回正常JSON结果',
  `T_ABNORMAL_JSON_RESULT` VARCHAR(255) NOT NULL COMMENT '返回异常JSON结果',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口表';


DROP TABLE IF EXISTS `T_REQ_PARAMETER`;
CREATE TABLE IF NOT EXISTS `T_REQ_PARAMETER`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_INTERFACE_ID` BIGINT(255) COMMENT '参数所属接口ID',
  `T_EN_NAME` VARCHAR(255) NOT NULL  COMMENT '参数英文名称',
  `T_ZH_NAME` VARCHAR(255) NOT NULL  COMMENT '参数中文名称',
  `T_PARAM_TYPE` CHAR(2) NOT NULL COMMENT '参数类型 00-String 01-Int 02-Double 03-DATE 04-ARRAY 05-OBJECT',
  `T_REQUIRE` CHAR(1) NOT NULL  COMMENT '是否是必填字段 0-非必填 1-必填',
  `T_PARAM_DESC` VARCHAR(255)  COMMENT '参数描述',
  `T_PARAM_DEMO` VARCHAR(255)  COMMENT '参数示例',
  `T_IS_COMMON` CHAR(1) NOT NULL  COMMENT '是否是公共参数 0-不是 1-是',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='请求参数表';

DROP TABLE IF EXISTS `T_RESP_RESULT`;
CREATE TABLE IF NOT EXISTS `T_RESP_RESULT`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_LEVEL` INTEGER COMMENT '参数级别',
  `T_PID` INTEGER COMMENT '父参数ID',
  `T_INTERFACE_ID` BIGINT(255) NOT NULL COMMENT '参数所属接口ID',
  `T_EN_NAME` VARCHAR(255) NOT NULL  COMMENT '响应参数英文名称',
  `T_ZH_NAME` VARCHAR(255) NOT NULL  COMMENT '响应参数中文名称',
  `T_TYPE` CHAR(2) NOT NULL COMMENT '响应参数类型 00-String 01-Int 02-Double 03-DATE 04-ARRAY 05-OBJECT',
  `T_REQUIRE` CHAR(1) NOT NULL  COMMENT '是否是必填字段 0-非必填 1-必填',
  `T_DESC` VARCHAR(255) COMMENT '响应参数描述',
  `T_DEMO` VARCHAR(255) COMMENT '响应参数示例',
  `T_IS_COMMON` CHAR(1) NOT NULL  COMMENT '是否是公共参数 0-不是 1-是',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='响应结果表';

DROP TABLE IF EXISTS `T_INTERFACE_ERROR`;
CREATE TABLE IF NOT EXISTS `T_INTERFACE_ERROR`(
  `T_ID` BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  `T_CODE` VARCHAR(255) NOT NULL COMMENT '错误码',
  `T_INTERFACE_ID` BIGINT(255) COMMENT '参数所属接口ID',
  `T_DESC` VARCHAR(255) COMMENT '错误描述',
  `T_REASON` VARCHAR(255) NOT NULL COMMENT '错误原因',
  `T_IS_COMMON` CHAR(1) NOT NULL  COMMENT '是否是公共错误代码 0-不是 1-是',
  `T_CREATE_TIME` DATETIME NOT NULL  COMMENT '创建时间'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口错误表';




