#! /bin/env python

import commands, sys, getopt, suds, time, psycopg2, urllib, urllib2, cookielib, random

provDBlog = '/usr/local/log/reprovision_provDBlog.log'
crceURL = 'http://crce01:8080/inew-mvno-crce-webservices/profiler/provisioning?wsdl'
# provURL= 'http://10.203.0.149:8080/inew-mvno-provisioning/CRMService?wsdl'
crceprofileURL = 'http://crce01:8080/inew-mvno-crce-webservices/profiler/subscriber?wsdl'

if len(sys.argv)!=4 :
    sys.stderr.write('USAGE: USSDtest.py MSISDN serviceCode subscriberLocation\n')
    sys.exit(1)

urlUssd = 'http://ussd-app01:8080/mvno/core-in/ussd/1/'

sessionId = random.randint(100000000, 999999999)
serviceCode = sys.argv[2]
subscriberLocation = sys.argv[3]
roamingType = 'ONNET'
requestType = 'process'
channel = 'USSD'

def getSubscriberProfile(msisdn):
    client = suds.client.Client(crceprofileURL, cache=None)
    result = client.service.getSubscriberProfile(msisdn)
#    print result
    return result

def getUssdMenu(subscriberProfile, ussdString):
    cookie_jar = cookielib.CookieJar()
    opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookie_jar))
    urllib2.install_opener(opener)
    continueSession = True
    while continueSession:
       values = dict(sessionId=sessionId, serviceCode=serviceCode, userData=ussdString, subscriberLocation=subscriberLocation, roamingType=roamingType, msisdn=subscriberProfile.msisdn, imsi=subscriberProfile.imsi, subscriberId=subscriberProfile.id, subscriberLanguage=subscriberProfile.language.lower(), subscriberType=subscriberProfile.type, providerId=subscriberProfile.providerId, subscriberState=subscriberProfile.state, requestType=requestType, channel=channel)
#       print values
       data = urllib.urlencode(values)
       req = urllib2.Request(urlUssd, data)
       rsp = urllib2.urlopen(req)
#       print rsp.info()
       if rsp.info().getheader('ContinueSession')=='false': continueSession = False
       content = rsp.read()
       print '=====================\n',content,'\n====================='
       if continueSession:
           ussdString = raw_input('User input: ')

if len(sys.argv) == 3:
    ussdString = sys.argv[2]
else:
    ussdString = ''

subscriberProfile = getSubscriberProfile(sys.argv[1])
getUssdMenu(subscriberProfile,ussdString)


