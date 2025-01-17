## 1 引言
### 1.1 编写目的
本手册叙述了在线购物网站（垂直领域选择：药品）如何安装和部署以及程序的启动和停止。本文档的预期读者为小组内所有开发成员。

### 1.2 项目背景
浙江工商大学软件2101第3小组的软件工程实践作业：在线购物网站。

### 1.3 软件清单
| 序号 | 软件名称 | 说明 |
| --- | ----- | --- |
| 1 | jdk-11.0.2 | JavaJDK |
| 2 | apache-tomcat-8.5.87 | Tomcat |
| 3.A | OnlineShopping.VX.X.X.war | webAPP |
| 3.B | XBro-OnlineShopping-X.X.X.zip(tar.gz) | Source Code |

### 1.4 说明
文档中未在代码块中出现的，以 %XXXXXX% 形式表示的资源路径都要以实际资源路径替换

## 2 运行环境
### 2.1 支持软件要求
| 类型 | 软件类型 | 软件名称 | 软件版本号 |
| --- | --- | --- | --- |
| 服务器 | 操作系统 | Windows Linux 等 | 所有支持Java的操作系统 |
| 服务器 | JAVA 运行环境 | SunJDK | 11.0.2 |
| 客户端 | 操作系统 | Windows Linux 等 | 主流操作系统 |
| 客户端 | 浏览器 | Edge Chrome 等 | 主流桌面浏览器 |

## 3 服务器安装配置
 服务器地址为`IP`
### 3.1 JAVA环境部署
 1. 下载对应系统版本的jdk-11.0.2压缩包
 2. 解压压缩包，解压得到的目录为`JAVA_HOME`
 3. 验证安装成功：
 执行指令 %JAVA_HOME%`\bin\java.exe -version`
 出现
 `java version "11.0.2" 2019-01-15 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.2+9-LTS)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.2+9-LTS, mixed mode)`
 即为安装成功

### 3.2 安装Tomcat
 1. 下载apache-tomcat-8.5.87的压缩包
 2. 解压压缩包，解压得到的目录进入下一级./bin的目录，此处为 `CATALINA_HOME`
 3. %CATALINA_HOME%`/setclasspath.bat` 中在
 `rem Make sure prerequisite environment variables are set`
 后添加
 `SET JAVA_HOME=`%JAVA_HOME%
 4. 运行 %CATALINA_HOME%`/setclasspath.bat`
 5. 更改 Tomcat 端口为 PORT 防止端口冲突（默认为8080）
 编辑 %CATALINA_HOME%`/../conf/server.xml` 中
 `<Connector port="8080" redirectPort="8443" connectionTimeout="20000" protocol="HTTP/1.1"/>`
 更改为
 `<Connector port="`%PORT%`" redirectPort="8443" connectionTimeout="20000" protocol="HTTP/1.1"/>`


### 3.3 安装webAPP并启动服务
#### 3.3A 使用WAR包安装
 1. https://github.com/lostyellow/XBro-OnlineShopping/releases 下载WAR包
 2. 将WAR包放到 %CATALINA_HOME%`/../webapps/` 目录下
 3. 运行 %CATALINA_HOME%`/startup.bat` 并检查报错，至此部署完毕
#### 3.3B 使用Source Code安装
 1. https://github.com/lostyellow/XBro-OnlineShopping/releases 下载Source Code，解压得到的目录为%SOURCE_CODE%
 2. 编辑 %SOURCE_CODE%`/OnlineShopping/src/main/cmd.bat`，将其中的`%CATALINA_HOME%`都更改为 %CATALINA_HOME%
 3. 运行 %SOURCE_CODE%`/OnlineShopping/src/main/cmd.bat` ，%SOURCE_CODE%`/OnlineShopping/src/main/` 中会出现一个 `OnlineShopping.war` 文件
 4. 将 `OnlineShopping.war` 文件放到 %CATALINA_HOME%`/../webapps/` 目录下
 5. 运行 %CATALINA_HOME%`/startup.bat` 并检查报错，至此部署完毕

### 3.4 关闭服务
 1. 运行 %CATALINA_HOME%`/shutdown.bat`

## 4 服务访问地址
 %IP%`:`%PORT%`/OnlineShopping`