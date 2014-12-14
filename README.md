# What is MediaWiki?

MediaWiki is a free and open-source wiki application, used to power wiki websites such as Wikipedia, Wiktionary and Commons; it was developed by the Wikimedia Foundation and others. It also runs thousands of other websites.

> [wikipedia.org/wiki/MediaWiki](wikipedia.org/wiki/MediaWiki)

# How to use this image

## Basic Usage

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
| /data         | This volume contains user-generated content included with the install.<br>/var/www/w/LocalSettings.php -> /data/LocalSettings.php<br>/var/www/w/images -> /data/images |
| /var/www/html | The Apache document root.                                                                                                   |
| /var/www/data | If using Sqlite, the Sqlite database file(s) are placed here.                                                                                                                              |

## Short URLs

### .htaccess

MediaWiki supports user-frienly URLs in the form of "/wiki/Page_title." Place a .htaccess file in the `/var/www/html` volume with the contents found below. For more information, visit [http://www.mediawiki.org/wiki/Manual:Short_URL/Apache](http://www.mediawiki.org/wiki/Manual:Short_URL/Apache).

```apache
# Enable the rewrite engine
RewriteEngine On

# Short url for wiki pages
RewriteRule ^/?wiki(/.*)?$ %{DOCUMENT_ROOT}/w/index.php [L]

# Redirect to Main Page
RewriteRule ^/*$ %{DOCUMENT_ROOT}/w/index.php [L]
```

### LocalSettings.php

You must also edit LocalSettings.php found in the `/data` volume. Note: The container ships with an Apache alias for /w (the default installation directory of MediaWiki).

```php
$wgScriptPath = "/w";
$wgArticlePath = "/wiki/$1";
```

## Search Engines

### robots.txt

To control the behavior of search engines, place a robots.txt in the `/var/www/html` volume. Note: It is recommended you block URLs in /w if using short URLs. For more information, visit [http://www.mediawiki.org/wiki/Manual:Robots.txt](http://www.mediawiki.org/wiki/Manual:Robots.txt).

```
User-agent: *
Disallow: /w/
```
