# What is MediaWiki?

MediaWiki is a free and open-source wiki application, used to power wiki websites such as Wikipedia, Wiktionary and Commons; it was developed by the Wikimedia Foundation and others. It also runs thousands of other websites.

> [wikipedia.org/wiki/MediaWiki](wikipedia.org/wiki/MediaWiki)

# How to use this image

## basic usage

```bash
docker run -d -p 8080:80 -v /some/data:/data -v /some/html:/var/www/html -v /some/db:/var/www/data --name mediawiki coryroloff/mediawiki
```

### Ports

| Port | Description                                                                                |
|------|--------------------------------------------------------------------------------------------|
| 80   | The Apache web port. Load http://localhost:80 to access the MediaWiki installation screen. |

### Volumes

| Volume        | Description                                                                                                                                                                                |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /data         | This volume contains user-generated content located inside the MediaWiki installation directory.<br>/var/www/w/LocalSettings.php -> /data/LocalSettings.php<br>/var/www/w/images -> /data/images |
| /var/www/html | The Apache document root. Files such as "robots.txt" and ".htaccess" may be placed here.                                                                                                   |
| /var/www/data | If using Sqlite, the Sqlite database file(s) are placed here.                                                                                                                              |
