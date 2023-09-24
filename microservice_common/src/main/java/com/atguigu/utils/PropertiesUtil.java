package com.atguigu.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @author: tang_su
 * @createTime: 2023/09/24 12:00
 * @company: https://www.ts.com
 * @description:
 */

public class PropertiesUtil {

  private static Properties props;

  static {
    InputStream inputStream = null;
    try {
      props = new Properties();
      inputStream = PropertiesUtil.class.getResourceAsStream("/application.yaml");
      props.load(inputStream);
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if(inputStream != null) {
        try {
          inputStream.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    }
  }

  public static String getVal(String key){
    return props.getProperty(key);
  }


  private PropertiesUtil() {
    throw new RuntimeException(this.getClass().getName() + " 不应该被创建实例");
  }

  public static void main(String[] args) {
    System.out.println(getVal("swagger.enable"));
  }

}
