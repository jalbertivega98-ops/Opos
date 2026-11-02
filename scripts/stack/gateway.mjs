// Pasarela local mínima que imita el enrutado de Supabase (Kong) en :54321.
//   /auth/v1/*  -> GoTrue   (127.0.0.1:9999)
//   /rest/v1/*  -> PostgREST (127.0.0.1:3001)
// SOLO DESARROLLO.
import http from "node:http";

const routes = [
  { prefix: "/auth/v1", port: 9999 },
  { prefix: "/rest/v1", port: 3001 },
];
const PORT = Number(process.env.GATEWAY_PORT ?? 54321);

const cors = {
  "access-control-allow-origin": "*",
  "access-control-allow-headers":
    "authorization, x-client-info, apikey, content-type, prefer, range, accept-profile, content-profile, x-supabase-api-version",
  "access-control-allow-methods": "GET, POST, PUT, PATCH, DELETE, OPTIONS",
  "access-control-expose-headers": "content-range, x-supabase-api-version",
};

http
  .createServer((req, res) => {
    if (req.method === "OPTIONS") {
      res.writeHead(204, cors);
      return res.end();
    }
    const route = routes.find((r) => req.url?.startsWith(r.prefix));
    if (!route) {
      res.writeHead(404, { "content-type": "application/json", ...cors });
      return res.end(JSON.stringify({ error: "not_found" }));
    }
    const path = req.url.slice(route.prefix.length) || "/";
    const headers = { ...req.headers, host: `127.0.0.1:${route.port}` };
    const upstream = http.request(
      { host: "127.0.0.1", port: route.port, path, method: req.method, headers },
      (up) => {
        res.writeHead(up.statusCode ?? 502, { ...up.headers, ...cors });
        up.pipe(res);
      },
    );
    upstream.on("error", (e) => {
      res.writeHead(502, { "content-type": "application/json", ...cors });
      res.end(JSON.stringify({ error: "bad_gateway", message: e.message }));
    });
    req.pipe(upstream);
  })
  .listen(PORT, "127.0.0.1", () => console.log(`gateway on :${PORT}`));
