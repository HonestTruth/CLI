#Depending on system this might be /usr/local/share/ca-certificates && update-ca-certificates
sudo curl -o /etc/pki/ca-trust/source/anchors/isrg-root-x1-cross-signed.crt https://letsencrypt.org/certs/isrg-root-x1-cross-signed.pem
sudo curl -o /etc/pki/ca-trust/source/anchors/isrg-root-x2-cross-signed.crt https://letsencrypt.org/certs/isrg-root-x2-cross-signed.pem
sudo update-ca-trust extract
sudo certbot renew --dry-run
# sudo vim /etc/cron.daily/certbotRenew