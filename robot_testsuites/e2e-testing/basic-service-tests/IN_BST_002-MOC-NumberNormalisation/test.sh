CLASSPATH_SOAPUI=/opt/soapui/bin/soapui-5.1.3.jar
for i in /opt/soapui/lib/*.jar; do
    echo $i
    CLASSPATH_SOAPUI=$CLASSPATH_SOAPUI:$i
done
echo $CLASSPATH_SOAPUI