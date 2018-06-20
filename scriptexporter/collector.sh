#!/usr/bin/env bash
EUREKA_URL='http://213.183.195.222:8761/eureka/apps'
APPLICATIONS=$(curl -k -s $EUREKA_URL | grep name | grep -v MyOwn | awk -F '[<>]' '{print $3}')
for app in $APPLICATIONS; do
  app_status_page_urls=$(curl -k -s ${EUREKA_URL}/${app} | grep statusPageUrl | awk -F '[<>]' '{print $3}' )
  for url in ${app_status_page_urls}; do
    echo "scriptexporter_http_status{app=\"$app\",url=\"$url\"} $(curl -s -o /dev/null -I -w "%{http_code}" $url)" &
  done
done
