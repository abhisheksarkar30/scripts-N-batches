@echo off
REM igv-tomcat
copy "C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\log4j-debug.properties" E:\apache-tomcat-7.0.57\webapps\igv-tomcat\WEB-INF\classes\log4j.properties
copy C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\%1\*-jdbc.properties E:\apache-tomcat-7.0.57\webapps\igv-tomcat\WEB-INF\classes\META-INF\spring\*
del E:\apache-tomcat-7.0.57\webapps\igv-*.war
REM igv-console
copy "C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\log4j-debug.properties" E:\igv-console\CONSOLE-INF\classes\log4j.properties
copy C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\%1\*-jdbc.properties E:\igv-console\CONSOLE-INF\classes\META-INF\spring\*
REM eig-console
copy C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\%1\csd.properties E:\EIG\conf\*
copy C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\%1\gv-reference-data.properties E:\EIG\conf\*
