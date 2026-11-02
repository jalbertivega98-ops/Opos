# Aprobia · Academia digital de oposiciones

Plataforma para preparar oposiciones en España (multioposición, freemium, castellano/catalán).

- Empieza por **[CLAUDE.md](CLAUDE.md)**, **[docs/SESSION_HANDOFF.md](docs/SESSION_HANDOFF.md)** y **[TASKS.md](TASKS.md)**.
- Puesta en marcha local: [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md).
- Arquitectura: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) · Base de datos: [docs/DATABASE.md](docs/DATABASE.md).

```bash
npm ci && npm run stack:setup && npm run stack:start -- --seed && npm run dev
npm run check && npm run test:db && npx playwright test
```
