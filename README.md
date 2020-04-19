## Foo support tool

### configuration
change `gradle.properties` the path of OpenCms's lib
```properties
    serverLibs=C:\\media\\DATA\\server\\apache-tomcat-8.5.39\\webapps\\ROOT\\WEB-INF\\lib\\
```

### to build
```jshelllanguage
    gradlew clean jar
```