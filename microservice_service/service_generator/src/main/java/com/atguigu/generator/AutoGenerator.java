package com.atguigu.generator;

import com.atguigu.utils.FileUtils;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig.Builder;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.keywords.MySqlKeyWordsHandler;
import jakarta.annotation.PostConstruct;
import java.util.Collections;

/**
 * @author: tang_su
 * @createTime: 2023/09/23 12:30
 * @company: https://www.ts.com
 * @description:
 * <a href=“https://juejin.cn/post/7049272958790926343”>参考地址之版本依赖</a>
 * <a href=“https://baomidou.com/pages/981406/”>参考地址之版本配置详情</a>
 * <a href=“https://baomidou.com/pages/981406/”>参考地址之版本配置详情</a>
 */
public class AutoGenerator {
  public static final String PATH = "/microservice_service/service_generator";

 public static GeneratorConfig config;
 @PostConstruct
 public void init(){
   // 创建GeneratorConfig对象的实例
   GeneratorConfig conf = new GeneratorConfig(
       "jdbc:mysql://192.168.9.88:3306/micro",
       "root", "123456",
       "ts", "/path/to/output", "com.atguigu", "generator"
   );
   config = conf;
   // 访问record的属性
   System.out.println("DataSource URL: " + config.dataSourceUrl());
   System.out.println("Author: " + config.author());

   // 访问静态属性
   System.out.println("Static x: " + GeneratorConfig.x);
 }
  public static void main(String[] args) {
    DataSourceConfig dataSourceConfig = getDataSourceConfig();
    FastAutoGenerator.create("jdbc:mysql://192.168.9.88:3306/micro", "root", "123456")
        .globalConfig(builder -> {
          builder.author("ts") // 设置作者
              .enableSwagger() // 开启 swagger 模式
              .outputDir(FileUtils.getProjectRootDirectory(PATH + "/src/main/java")) // 指定输出目录
              .dateType(DateType.TIME_PACK)
              .commentDate("yyyy-MM-dd")
              .fileOverride() // 覆盖已生成文件
              .disableOpenDir() // 不打开目录
          ;
        })
        .packageConfig(builder -> {
          builder.parent("com.atguigu") // 设置父包名
              .moduleName("generator") // 设置父包模块名
              .entity("po")
              .service("service")
              .serviceImpl("service.impl")
              .mapper("mapper")
              .xml("mapper.xml")
              .controller("controller")
              // .other("other") // 输出自定义文件时所用到的包名
              .pathInfo(Collections.singletonMap(OutputFile.mapperXml,
                  FileUtils.getProjectRootDirectory(PATH + "/src/main/resources/mapper"))); // 设置mapperXml生成路径
        })
        .strategyConfig(builder -> {
          builder
              .enableSkipView()
              .addInclude("user") // 设置需要生成的表名
              .addTablePrefix("t_", "c_") // 设置过滤表前缀
              .addFieldSuffix("_flag")  // 设置过滤表后缀
              .entityBuilder()
              .enableLombok()
              .enableChainModel()
              .naming(NamingStrategy.underline_to_camel) // 数据表映射实体命名策略：默认下划线转驼峰underline_to_camel
              .columnNaming(NamingStrategy.underline_to_camel) // 表字段映射实体属性命名规则：默认null，不指定按照naming执行
              .idType(IdType.ASSIGN_ID) // 添加全局主键类型
              .formatFileName("%s") // 格式化实体名称，%s取消首字母I,
              .mapperBuilder()
              .enableBaseResultMap() // 启用xml文件中的BaseResultMap 生成
              .enableBaseColumnList() // 启用xml文件中的BaseColumnList
              .formatMapperFileName("%sMapper") // 格式化Dao类名称
              .formatXmlFileName("%sMapper") // 格式化xml文件名称
              .serviceBuilder()
              .formatServiceFileName("%sService") // 格式化 service 接口文件名称
              .formatServiceImplFileName("%sServiceImpl") // 格式化 service 接口文件名称
              .controllerBuilder()
              .enableRestStyle();
        })

        // 使用Freemarker引擎模板，默认的是Velocity引擎模板
        // .templateEngine(new FreemarkerTemplateEngine())
        .execute();
  }

  private static DataSourceConfig getDataSourceConfig() {
    return new Builder("jdbc:mysql://127.0.0.1:3306/mybatis-plus", "root",
        "123456")
        .schema("mybatis-plus")
        .keyWordsHandler(new MySqlKeyWordsHandler())
        .build();
  }

}
