@Echo Off&Setlocal Enabledelayedexpansion

: This batch file for Windows auto update the public IPv6 address to DYNV6 API.

: Please replace dynv6's token and Ddomain here.

set _ToKen=<Your ynv6's Token xxxxxxxxxxxxxxxxxx>

set _myDomain=<Your Dynamic Domain xxxxx.xxx.xxx>

TITLE UPDATE DYNV6 ADDDRESS

: Detect and list all IPv6 address.

ipconfig | findstr IPv6 > v6.log

: pick up the Global IPv6 address strings.

for /f "tokens=14" %%i in (v6.log) do ( ECHO %%i >>v6_tmp.log
)
For /f "delims=" %%u in (v6_tmp.log) do (
Set /a n+=1
If !n!==1 Set _ip6addr=%%u
If !n!==3 Set _ip6lanprefix=%%u
)

: Remove all space of strings.
set _ip6addr=%_ip6addr: =%
set _ip6lanprefix:=%_ip6lanprefix: =%

: Udate the DYNV6 records.
START http://dynv6.com/api/update?hostname=%_myDomain%^&token=%_ToKen%^&ipv6=%_ip6addr%^&ipv6prefix=%_ip6lanprefix%
del v6_tmp.log
del v6.log
EXIT
