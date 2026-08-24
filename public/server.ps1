$code = @"
using System;
using System.IO;
using System.Net;
using System.Threading.Tasks;

public class SimpleServer {
    public static void Start() {
        HttpListener listener = new HttpListener();
        listener.Prefixes.Add("http://localhost:8081/");
        listener.Prefixes.Add("http://127.0.0.1:8081/");
        listener.Start();
        Console.WriteLine("Listening on http://localhost:8081/");

        string basePath = @"c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public";

        while (true) {
            try {
                HttpListenerContext context = listener.GetContext();
                Task.Run(() => ProcessRequest(context, basePath));
            } catch (Exception ex) {
                Console.WriteLine("GetContext error: " + ex.Message);
            }
        }
    }

    private static void ProcessRequest(HttpListenerContext context, string basePath) {
        try {
            string url = context.Request.Url.LocalPath;
            url = url.Replace("..", "");
            
            string path = Path.Combine(basePath, url.TrimStart('/'));
            
            if (Directory.Exists(path)) {
                string indexPath = Path.Combine(path, "index.html");
                if (File.Exists(indexPath)) {
                    path = indexPath;
                }
            } else if (!File.Exists(path) && File.Exists(path + ".html")) {
                path = path + ".html";
            }
            
            if (File.Exists(path)) {
                string ext = Path.GetExtension(path).ToLower();
                switch (ext) {
                    case ".html": context.Response.ContentType = "text/html; charset=utf-8"; break;
                    case ".css": context.Response.ContentType = "text/css"; break;
                    case ".js": context.Response.ContentType = "application/javascript"; break;
                    case ".png": context.Response.ContentType = "image/png"; break;
                    case ".jpg": context.Response.ContentType = "image/jpeg"; break;
                    case ".svg": context.Response.ContentType = "image/svg+xml"; break;
                    case ".woff2": context.Response.ContentType = "font/woff2"; break;
                    case ".woff": context.Response.ContentType = "font/woff"; break;
                    case ".ttf": context.Response.ContentType = "font/ttf"; break;
                    default: context.Response.ContentType = "application/octet-stream"; break;
                }
                byte[] buffer = File.ReadAllBytes(path);
                context.Response.ContentLength64 = buffer.Length;
                context.Response.AddHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                context.Response.AddHeader("Pragma", "no-cache");
                context.Response.AddHeader("Expires", "0");
                context.Response.OutputStream.Write(buffer, 0, buffer.Length);
                context.Response.StatusCode = 200;
            } else {
                context.Response.StatusCode = 404;
            }
        } catch (Exception ex) {
            Console.WriteLine("ProcessRequest error: " + ex.Message);
            context.Response.StatusCode = 500;
        } finally {
            context.Response.Close();
        }
    }
}
"@

Add-Type -TypeDefinition $code
[SimpleServer]::Start()
