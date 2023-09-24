package com.atguigu.gateway.enums;

/**
 * 服务路由枚举
 * @author: tang_su
 * @createTime: 2023/09/23 23:21
 * @company: https://www.ts.com
 * @description:
 */
public enum ServerRouteEnum {

  /**
   * 路由信息
   */
  CORE_ROUTE("core-route", "开放平台鉴权配置接口");

  private String routeId;
  private String swaggerInfo;

  ServerRouteEnum(String routeId, String swaggerInfo) {
    this.routeId = routeId;
    this.swaggerInfo = swaggerInfo;
  }

  /**
   * 根据路由id获取swagger信息
   *
   * @param routId 路由id
   * @return swagger信息
   */
  public static String getSwaggerInfoByRoutId(String routId) {
    for (ServerRouteEnum routeEnum : ServerRouteEnum.values()) {
      if (routId.equals(routeEnum.getRouteId())) {
        return routeEnum.getSwaggerInfo();
      }
    }
    return null;
  }

  /**
   * @return the routeId
   */
  public String getRouteId() {
    return routeId;
  }

  /**
   * @param routeId : the routeId to set
   */
  public void setRouteId(String routeId) {
    this.routeId = routeId;
  }

  /**
   * @return the swaggerInfo
   */
  public String getSwaggerInfo() {
    return swaggerInfo;
  }

  /**
   * @param swaggerInfo : the swaggerInfo to set
   */
  public void setSwaggerInfo(String swaggerInfo) {
    this.swaggerInfo = swaggerInfo;
  }
}
