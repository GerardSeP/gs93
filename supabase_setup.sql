-- Ejecuta este script UNA VEZ en Supabase → SQL Editor → New query → Run.
-- Crea una fila por usuario con todos sus datos de liquidación y protege el acceso:
-- cada persona solo puede ver y modificar SU fila.

create table if not exists public.app_state (
  user_id    uuid primary key references auth.users (id) on delete cascade default auth.uid(),
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  constraint app_state_size check (pg_column_size(data) < 200000)
);

alter table public.app_state enable row level security;

create policy "app_state_select_own" on public.app_state
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "app_state_insert_own" on public.app_state
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "app_state_update_own" on public.app_state
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "app_state_delete_own" on public.app_state
  for delete to authenticated using ((select auth.uid()) = user_id);
