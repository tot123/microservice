package com.atguigu.utils;

import java.io.File;
/**
 * 文件操作工具类.
 *
 * 该类提供了用于文件和目录操作的方法.
 *
 * @author: tang_su
 * @createTime: 2023/09/23 21:38
 * @company: https://www.ts.com
 * @description: 文件操作工具类.
 */
public class FileUtils {

  /**
   * 获取项目根目录.
   *
   * @return 项目根目录路径.
   */
  public static String getProjectRootDirectory() {
    return System.getProperty("user.dir");
  }

  /**
   * 获取带有指定路径的项目根目录.
   *
   * @param path 要附加到项目根目录的附加路径.
   * @return 带有指定路径附加的项目根目录路径.
   */
  public static String getProjectRootDirectory(String path) {
    return System.getProperty("user.dir") + path;
  }

  /**
   * 获取当前目录.
   *
   * @return 当前目录路径.
   */
  public static String getCurrentDirectory() {
    return new File("").getAbsolutePath();
  }

  /**
   * 获取项目中的资源目录.
   *
   * @return 资源目录路径.
   */
  public static String getResourceDirectory(String path) {
    return System.getProperty("user.dir") + path + "/src/main/resources";
  }
  /**
   * 获取项目中的资源目录.
   *
   * @return 资源目录路径.
   */
  public static String getResourceDirectory() {
    return System.getProperty("user.dir") + "/src/main/resources";
  }

  public static void main(String[] args) {
    String projectRoot = getProjectRootDirectory();
    String currentDirectory = getCurrentDirectory();
    String resourceDirectory = getResourceDirectory();

    System.out.println("项目根目录: " + projectRoot);
    System.out.println("当前目录: " + currentDirectory);
    System.out.println("当前目录: " + resourceDirectory);
  }
}