#!/bin/sh

# Check if there's a custom certificate
if [ "$(ls -A /etc/letsencrypt/live/$SRP_PROXY_URL 2> /dev/null)" ]
then
    echo "Certificate detected. Skipping certbot certificate generation..."
else
    echo "No certificate detected. Generating certificate with certbot..."
    certbot certonly --agree-tos --standalone \
        -d $SRP_PROXY_URL \
        -m diwangs@outlook.com
    # Start cron job for automatic renewal
    echo "* * * * 0 ec2-user certbot renew --pre-hook 'service nginx stop' --post-hook 'service nginx start'" >> /etc/crontab
    echo "Weekly cronjob created!"
fi

sed -i "s/tobechanged/$SRP_PROXY_URL/g" /etc/nginx/conf.d/app.conf
sed -i "s/tobe2changed/$SRP_DOWNSTREAM_URL/g" /etc/nginx/conf.d/app.conf
service nginx start
echo "Reverse proxy server is running!"

tail -f /dev/null
