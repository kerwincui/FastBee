Android项目打包
1. 修改工程根目录的gradle.properties中的isNeedPackage=true。
2. 添加并配置keystore，在versions.gradle中修改app_release相关参数。
3. 如果考虑使用友盟统计的话，在local.properties中设置应用的友盟ID:APP_ID_UMENG。
4. 使用./gradlew clean assembleReleaseChannels进行多渠道打包。