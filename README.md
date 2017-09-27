# XPressoLab Parent 

[![Build Status](https://travis-ci.org/xpressolab/xpresso-parent.svg?branch=master)](https://travis-ci.org/xpressolab/xpresso-parent) [![codecov](https://codecov.io/gh/xpressolab/xpresso-parent/branch/master/graph/badge.svg)](https://codecov.io/gh/xpressolab/xpresso-parent)


# Utilizao:

Declare o `<parent />` no seu pom.xml, conforme exemplo abaixo:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>xpresso.foundation</groupId>
        <artifactId>xpresso-parent</artifactId>
        <version>VERSION</version>
    </parent>
    
    ...
    
</project>
```
