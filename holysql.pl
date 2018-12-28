#!/usr/bin/perl
use File::Basename;
use FindBin '$Bin';
use strict;
use warnings;
use Term::ANSIColor;
use URI::Escape;
use HTML::Entities;
use HTTP::Request::Common;
use Digest::MD5;
use MIME::Base64;
use Net::Ping;
use HTTP::Cookies;

## Copy@right SMARTSOFT Technology see License.txt

## INTRODUCTION ###########################################################################################
#   This script is Copyright (c) 2018 SMARTSOFT Technology
#   [::] SCRIPT NAME:  Holysql scanner
#   [::] AUTOR:        SMARTSOFT TECHNOLOGY
#   [::] FB:           https://facebook.com/SMARTSOFT.Technology
#   [::] Twitter:      https://twitter.com/SMARTSOFTTechno
#   [::] Pastebin      http://http://pastebin.com/u/Mbmgamer1
#   [::] GIT:          https://github.com/igemcoin
#   [::] YOUTUBE:      http://youtube.com/c/SMARTSOFT
#
## DESCRIPTION ###########################################################################################
#   Tool to scan engines, dorks and sites for commun errors and vulnerabilities.
#   Search engine 
#   XSS scanner. 
#   LFI / ADF scanner.
#   Filter wordpress and Joomla sites in the server. 
#   Find Admin page.
#   Decode / Encode MD5 + Base64.
#   Ports scan. 
#   Scan E-mails in sites. 
#   Use proxy. 
#   Random user agent. 
#   Random proxy. 
#   Scan errors. 
#   Detect Cms.
#   Multiple instant scans. 
#   Extern commands execution.
#   Usage by commands and by an easy interactive mode. 
#   Disponible on BlackArch Linux and DracOs systems.
#   Works in all platforms.
#   Perl required!
##########################################################################################################

## CHECK INC DIR 
if (!-d $Bin."/inc") {
  print "[!] No components found..\n";
  print "[!] Downoloading components Please wait..\n";
  system("git clone https://github.com/igemcoin/Holy.git $Bin/atscan_update");
  if (-e "$Bin/atscan.pl") {
    system("chmod +x $Bin/atscan.pl");
    unlink "$Bin/atscan.pl";
  }
  mkdir "$Bin/inc", 0755 or die "cannot write in $Bin!";
  system "sudo cp -r $Bin/atscan_update/* $Bin/";
  system "rm -rf $Bin/atscan_update";  
  if (!-d "$Bin/inc") { print "\n[!] Cannot connect to the server!\n"; exit(); }
  system("chmod +x $Bin/atscan.pl | perl $Bin/atscan.pl --update || atscan --update");
}

## ALL ARRAYS
our (@c, @XSS, @LFI, @RFI, @ADFWP, @ADMIN, @SUBDOMAIN, @UPLOAD, @ZIP, @TT, @OTHERS, @AUTH, @ErrT, @DT, @DS, @cms, @SCAN_TITLE, @E_MICROSOFT, @E_ORACLE, @E_DB2, @E_ODBC, @E_POSTGRESQL, @E_SYBASE,
     @E_JBOSSWEB, @E_JDBC, @E_JAVA, @E_PHP, @E_ASP, @E_LUA, @E_UNDEFINED, @E_MARIADB, @E_SHELL, @strings, @browserlangs, @googleDomains, @Ids, @MsIds, @sys, @vary, @buildArrays, @dorks, @z, @ZT, 
     @userArraysList, @exploits, @data, @proxies, @aTsearch, @aTscans, @defaultHeaders, @userHeaders, @aTtargets, @aTcopy, @ports, @motor, @motors, @systems, @mrands, @allMotors, @V_WP, @V_JOOM, @V_TP, @V_SMF, @V_VB, @V_MyBB,
     @V_CF, @V_DRP, @V_PN, @V_AT, @V_PHPN, @V_MD, @V_ACM, @V_SS, @V_MX, @V_XO, @V_OSC, @V_PSH, @V_BB2, @V_MG, @V_ZC, @V_CC5, @V_OCR, @V_XSS, @V_LFI,@V_TODO, @V_AFD, @TODO, @V_VALID, @ERR, @CMS,
     @validTexts, @notIns)=();

## TOP CONFIG
require "$Bin/inc/top.pl";

## VARIABLES 
our ($Version, $logoVersion, $scriptUrl, $logUrl, $ipUrl, $conectUrl, $script, $script_bac, $scriptbash, $paylNote, $psx, $V_EMAIL, $V_IP, $V_RANG, $V_SEARCH, $V_REGEX, $S_REGEX, $motor1, $motor2,
     $motor3, $motor4, $motor5, $motorparam, $mrand, $pat2, $nolisting, $Hstatus, $validText, $WpSites, $JoomSites, $xss, $lfi, $JoomRfi, $WpAfd, $adminPage, $subdomain, $mupload, $mzip,
     $eMails, $command, $mmd5, $mencode64, $mdecode64, $port, $mindex, $mdom, $Target, $exploit, $p, $tcp, $udp, $proxy, $prandom, $help, $output, $replace, $replaceFROM, $dork, $mlevel, $unique,
     $shell, $nobanner, $beep, $ifinurl, $noinfo, $motor, $timeout, $limit, $checkVersion, $searchIps, $regex, $searchRegex, $noQuery, $ifend, $uninstall, $post, $get, $brandom, $data, $payloads,
     $mrandom, $content, $scriptComplInstall, $scriptCompletion, $scriptInstall, $toolInfo, $config, $freq, $headers, $msource, $ping, $notIn, $expHost, $expIp, $zone, $validShell, $interactive,
     $popup, $all, $repair, $zoneH, $cokie, $bugtraq);

## ARGUMENTS
use Getopt::Long qw(GetOptions);
our %OPT;
Getopt::Long::GetOptions(\%OPT, 'status=s'=>\$Hstatus, 'valid|v=s'=>\$validText, 'wp'=>\$WpSites, 'joom'=>\$JoomSites, 'sql'=>\$xss, 'lfi'=>\$lfi, 'joomrfi'=>\$JoomRfi, 'wpafd'=>\$WpAfd,
                         'admin'=>\$adminPage, 'shost'=>\$subdomain, 'upload'=>\$mupload, 'zip'=>\$mzip, 'email'=>\$eMails, 'command|c=s'=>\$command, 'md5=s'=>\$mmd5, 'encode64=s'=>\$mencode64,
                         'decode64=s'=>\$mdecode64, 'port=s'=>\$port, 'index'=>\$mindex, 'host'=>\$mdom, 't|target=s'=>\$Target, 'exp|e=s'=>\$exploit, 'p|param=s'=>\$p, 'tcp'=>\$tcp, 'udp'=>\$udp, 
                         'proxy=s'=>\$proxy, 'proxy-random=s'=>\$prandom, 'help|h'=>\$help, 'save|s=s'=>\$output, 'replace=s'=>\$replace, 'replaceFROM=s'=>\$replaceFROM, 'dork|d=s'=>\$dork, 'level|l=s'=>\$mlevel,
                         'unique'=>\$unique, 'shell=s'=>\$shell, 'nobanner'=>\$nobanner, 'beep'=>\$beep, 'ifinurl=s'=>\$ifinurl, 'noinfo'=>\$noinfo, 'm|motor=s'=>\$motor, 'timeout=s'=>\$timeout,
                         'limit=s'=>\$limit, 'update'=>\$checkVersion, 'ip'=>\$searchIps, 'regex=s'=>\$regex, 'sregex=s'=> \$searchRegex, 'noquery'=> \$noQuery, 'ifend'=>\$ifend,
                         'uninstall'=> \$uninstall, 'post'=>\$post, 'get'=>\$get, 'b-random'=>\$brandom, 'data=s'=>\$data, 'payload=s'=>\$payloads, 'm-random'=>\$mrandom, 'content'=>\$content,
                         'tool|?'=>\$toolInfo, 'pass|config'=>\$config, 'freq=s'=>\$freq, 'header=s'=>\$headers, 'source=s'=>\$msource, 'ping'=>\$ping, 'exclude=s'=>\$notIn, 'expHost=s'=>\$expHost,
                         'expIp=s'=>\$expIp, 'zone=s'=>\$zone, 'interactive|i'=>\$interactive, 'vshell=s'=>\$validShell, 'popup'=>\$popup, 'all'=>\$all, 'repair'=>\$repair, 'zoneH=s'=>\$zoneH,
                         'cookies=s'=>\$cokie, 'bugtraq=s'=>\$bugtraq) or badArgs();

## CHOMP ARGS STRINGS
our @toChomp=($Hstatus, $validText, $command, $mmd5, $mencode64, $mdecode64, $port, $Target, $exploit, $p, $proxy, $prandom, $output,
              $replace, $replaceFROM, $dork, $mlevel, $shell, $ifinurl, $motor, $timeout, $limit, $regex, $searchRegex, $data,
              $payloads, $freq, $headers, $msource, $notIn, $expHost, $expIp, $zone, $validShell, $zoneH, $bugtraq);
for (@toChomp) { chomp ($_) if defined $_; }

## INCLUDES
require "$Bin/inc/includes.pl";

## EXIT
require "$Bin/inc/bottom.pl";