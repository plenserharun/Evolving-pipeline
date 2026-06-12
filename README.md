# Evolving Pipeline

Static quotation tracking app with PDF upload, Supabase-backed quotation history, user management, access logs, and spreadsheet-style quotation viewing.

## Files

- `index.html` - main app entry for Vercel and static hosting.
- `public/index.html` - Cloudflare Workers/Pages static asset entry.
- `supabase-setup.sql` - SQL to run in Supabase before connecting the app.
- `wrangler.toml` - Cloudflare deploy config.
- `vercel.json` - Vercel rewrite config.

## Vercel

Use these settings:

- Framework Preset: `Other`
- Build Command: `npm run build`
- Output Directory: `.`
- Install Command: `npm install`

## Cloudflare

Use:

```bash
npm run deploy:cloudflare
```

The Cloudflare static assets directory is `./public`.

## Supabase

1. Open Supabase SQL Editor.
2. Paste the full contents of `supabase-setup.sql`.
3. Run the SQL.
4. Open the app as admin.
5. Go to `Supabase`.
6. Paste the project URL and anon public key.
7. Click `Save connection`, then `Sync now`.
