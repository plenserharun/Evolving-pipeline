-- Evolving Pipeline Supabase setup
-- Run this in Supabase SQL Editor before connecting the HTML app.

create extension if not exists "pgcrypto";

create table if not exists public.ep_users (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null unique,
  password text not null,
  role text not null default 'user',
  active boolean not null default true,
  last_access text,
  created_at timestamptz not null default now()
);

create table if not exists public.ep_quotations (
  id uuid primary key default gen_random_uuid(),
  number text not null unique,
  class text not null default 'ET',
  title text,
  customer text,
  amount text,
  assigned_to text,
  status text default 'Open',
  file_name text,
  file_url text,
  imported_at text,
  created_at timestamptz not null default now()
);

create table if not exists public.ep_access_logs (
  id uuid primary key default gen_random_uuid(),
  user_name text,
  email text,
  action text,
  stamp text,
  created_at timestamptz not null default now()
);

insert into public.ep_users (name, email, password, role, active)
values ('System Admin', 'admin@evolvingtechkenya.com', 'Admin@123', 'admin', true)
on conflict (email) do nothing;

insert into storage.buckets (id, name, public)
values ('quotation-files', 'quotation-files', true)
on conflict (id) do update set public = true;

alter table public.ep_users enable row level security;
alter table public.ep_quotations enable row level security;
alter table public.ep_access_logs enable row level security;

drop policy if exists "ep_users_public_read" on public.ep_users;
drop policy if exists "ep_users_public_write" on public.ep_users;
drop policy if exists "ep_quotations_public_read" on public.ep_quotations;
drop policy if exists "ep_quotations_public_write" on public.ep_quotations;
drop policy if exists "ep_access_logs_public_read" on public.ep_access_logs;
drop policy if exists "ep_access_logs_public_write" on public.ep_access_logs;

create policy "ep_users_public_read" on public.ep_users for select using (true);
create policy "ep_users_public_write" on public.ep_users for all using (true) with check (true);
create policy "ep_quotations_public_read" on public.ep_quotations for select using (true);
create policy "ep_quotations_public_write" on public.ep_quotations for all using (true) with check (true);
create policy "ep_access_logs_public_read" on public.ep_access_logs for select using (true);
create policy "ep_access_logs_public_write" on public.ep_access_logs for all using (true) with check (true);

drop policy if exists "quotation_files_public_read" on storage.objects;
drop policy if exists "quotation_files_public_write" on storage.objects;

create policy "quotation_files_public_read"
on storage.objects for select
using (bucket_id = 'quotation-files');

create policy "quotation_files_public_write"
on storage.objects for all
using (bucket_id = 'quotation-files')
with check (bucket_id = 'quotation-files');
