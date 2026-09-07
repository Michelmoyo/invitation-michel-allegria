create table if not exists guests (
  code text primary key,
  nom text not null,
  accompagnants int not null default 0,
  statut text not null default 'en_attente',
  checked_in boolean not null default false,
  checked_in_at timestamptz,
  date_ajout timestamptz not null default now(),
  date_reponse timestamptz
);

alter table guests enable row level security;

create policy "guests_public_select" on guests for select using (true);
create policy "guests_public_insert" on guests for insert with check (true);
create policy "guests_public_update" on guests for update using (true);

insert into guests (code, nom, statut)
values ('demo', 'Monsieur Michel', 'en_attente')
on conflict (code) do nothing;

alter publication supabase_realtime add table guests;

-- Ajouté le 07/09/2026 : politique manquante, empêchait "Supprimer" de fonctionner
create policy "guests_public_delete" on guests for delete using (true);
