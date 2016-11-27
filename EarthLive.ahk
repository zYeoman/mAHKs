While true
{
    url_start := "http://res.cloudinary.com/mickircloud/image/fetch/http://himawari8-dl.nict.go.jp/himawari8/img/D531106/1d/550/"
    url_start := "http://himawari8-dl.nict.go.jp/himawari8/img/D531106/1d/550/"
    url_end   := "000_0_0.png"
    now = %a_nowutc%
    now += -15, minutes
    formattime, url, %now%,yyyy/MM/dd/HHmm
    url_short := substr(url, 1, strlen(url)-1)
    url = %url_start%%url_short%%url_end%
    _download_to_file(url, a_temp . "\wallpaper.png")
    DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, a_temp . "\Wallpaper.png", UInt, 1)
    Sleep, 600000
}



;Function by Wicked
_download_to_file(u,s){
	static r:=false,request:=comobjcreate("WinHttp.WinHttpRequest.5.1")
	if(!r||request.option(1)!=u)
		request.open("GET",u)
    ;request.SetProxy(2, "XXX.XXX.XXX.XXX:PORT") ; IF YOU NEED TO SET YOUR PROXY
	request.send()
	if(request.responsetext="failed"||request.status!=200||comobjtype(request.responsestream)!=0xd)
		return false
	p:=comobjquery(request.responsestream,"{0000000c-0000-0000-C000-000000000046}")
	f:=fileopen(s,"w")
	loop{
		varsetcapacity(b,8192)
		r:=dllcall(numget(numget(p+0)+3*a_ptrsize),ptr,p,ptr,&b,uint,8192, "ptr*",c)
		f.rawwrite(&b,c)
	}until (c=0)
	objrelease(p)
	f.close()
	return request.responsetext
}
