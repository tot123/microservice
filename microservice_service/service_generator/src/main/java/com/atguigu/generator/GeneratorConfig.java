package com.atguigu.generator;

/**
 * @author: tang_su
 * @createTime: 2023/09/23 21:46
 * @company: https://www.ts.com
 * @description:
 */
record GeneratorConfig(String dataSourceUrl, String dataSourceUserName, String dataSourcePassword
 , String author, String outputDir, String parent, String model) {
  static int x;

  // 构造函数
  public GeneratorConfig(String dataSourceUrl, String dataSourceUserName, String dataSourcePassword,
      String author, String outputDir, String parent, String model) {
    this.dataSourceUrl = dataSourceUrl;
    this.dataSourceUserName = dataSourceUserName;
    this.dataSourcePassword = dataSourcePassword;
    this.author = author;
    this.outputDir = outputDir;
    this.parent = parent;
    this.model = model;
  }
}
