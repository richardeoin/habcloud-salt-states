<?php
$conf['title'] = 'UKHAS Wiki';
$conf['tagline'] = 'UK High Altitude Society';
$conf['license'] = '0';
$conf['basedir'] = '/';
$conf['baseurl'] = 'https://ukhas.org.uk/';
$conf['useacl'] = 1;
$conf['superuser'] = '@admin';
$conf['userewrite'] = '1';
$conf['plugin']['recaptcha']['lang'] = 'en';
$conf['plugin']['recaptcha']['editprotect'] = 0;
$conf['mailfrom'] = 'dokuwiki@ukhas.org.uk';
$conf['indexdelay'] = 0;

define("DOKU_SESSION_NAME", "DOKUWIKI_SESSION");
define("DOKU_COOKIE", "DOKUWIKI_AUTH");
$conf['breadcrumbs'] = 0;
$conf['youarehere'] = 0;

require '/srv/ukhas-dokuwiki/conf/local.keys.php';
