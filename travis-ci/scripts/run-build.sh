#!/usr/bin/env bash
set -ev
./gradlew clean check
older_gradle_versions=()
oracle_prefix="oraclejdk"
openjdk_prefix="openjdk"
jdk_version=${TRAVIS_JDK_VERSION#"$oracle_prefix"}
jdk_version=${jdk_version#"$openjdk_prefix"}
if [[ ${jdk_version} -lt 8 || ${jdk_version} == 8 ]]; then
    older_gradle_versions+=(3.2 3.5.1 4.0 4.10.3)
fi

if [[ ${jdk_version} -lt 11 || ${jdk_version} == 11 ]]; then
    older_gradle_versions+=(5.0)
fi

for gradle_version in ${older_gradle_versions[@]} ; do
    ./gradlew clean check -Dtest.gradleVersion=${gradle_version}
done
./gradlew clean install
./gradlew -b sample/groovy-spring-boot-jaxrs/build.gradle clean generateSwaggerDocumentation
./gradlew -b sample/groovy-spring-boot-mvc/build.gradle clean generateSwaggerDocumentation
./gradlew -b sample/java-spring-boot-jaxrs/build.gradle clean generateSwaggerDocumentation
./gradlew -b sample/java-spring-boot-mvc/build.gradle clean generateSwaggerDocumentation
./gradlew -b sample/kotlin-spring-boot-jaxrs/build.gradle clean generateSwaggerDocumentation
./gradlew -b sample/kotlin-spring-boot-mvc/build.gradle clean generateSwaggerDocumentation
./gradlew -b sample/scala-spring-boot-jaxrs/build.gradle clean generateSwaggerDocumentation
./gradlew -b sample/scala-spring-boot-mvc/build.gradle clean generateSwaggerDocumentation
