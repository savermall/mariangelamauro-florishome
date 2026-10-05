const http=require('http'),fs=require('fs'),path=require('path');
const root="/home/saverio/.openclaw/workspace/florishome-site";
const port=process.env.PORT||8137;
const types={'.html':'text/html; charset=utf-8','.css':'text/css; charset=utf-8','.js':'application/javascript','.jpg':'image/jpeg','.jpeg':'image/jpeg','.png':'image/png','.svg':'image/svg+xml','.json':'application/json','.ico':'image/x-icon'};
http.createServer((req,res)=>{
  let p=decodeURIComponent((req.url||'/').split('?')[0]);
  if(p==='/'||p==='')p='/index.html';
  const f=path.join(root, path.normalize(p).replace(/^(\.\.(\/|\\|$))+/, ''));
  fs.readFile(f,(e,d)=>{
    if(e){res.writeHead(404,{'content-type':'text/plain'});return res.end('404');}
    res.writeHead(200,{'content-type':types[path.extname(f).toLowerCase()]||'application/octet-stream','cache-control':'no-store'});
    res.end(d);
  });
}).listen(port,'127.0.0.1',()=>console.log('listening '+port));