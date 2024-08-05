create table "public"."companies" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "name" text not null,
    "sector" text,
    "size" smallint,
    "linkedin_url" text,
    "website" text,
    "phone_number" text,
    "address" text,
    "zipcode" text,
    "city" text,
    "stateAbbr" text,
    "sales_id" bigint,
    "context_links" json,
    "country" text,
    "description" text,
    "revenue" text,
    "tax_identifier" text,
    "logo" jsonb
);


alter table "public"."companies" enable row level security;

create table "public"."contactNotes" (
    "id" bigint generated by default as identity not null,
    "contact_id" bigint not null,
    "text" text,
    "date" timestamp with time zone default now(),
    "sales_id" bigint,
    "status" text,
    "attachments" jsonb[]
);


alter table "public"."contactNotes" enable row level security;

create table "public"."contacts" (
    "id" bigint generated by default as identity not null,
    "first_name" text,
    "last_name" text,
    "gender" text,
    "title" text,
    "email" text,
    "phone_number1" text,
    "phone_number2" text,
    "background" text,
    "acquisition" text,
    "avatar" jsonb,
    "first_seen" timestamp with time zone,
    "last_seen" timestamp with time zone,
    "has_newsletter" boolean,
    "status" text,
    "tags" bigint[],
    "company_id" bigint,
    "sales_id" bigint,
    "linkedin_url" text
);


alter table "public"."contacts" enable row level security;

create table "public"."dealNotes" (
    "id" bigint generated by default as identity not null,
    "deal_id" bigint not null,
    "type" text,
    "text" text,
    "date" timestamp with time zone default now(),
    "sales_id" bigint,
    "attachments" jsonb[]
);


alter table "public"."dealNotes" enable row level security;

create table "public"."deals" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "company_id" bigint,
    "contact_ids" bigint[],
    "category" text,
    "stage" text not null,
    "description" text,
    "amount" bigint,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now(),
    "archived_at" timestamp with time zone default null,
    "expected_closing_date" timestamp with time zone default null,
    "sales_id" bigint,
    "index" smallint
);


alter table "public"."deals" enable row level security;

create table "public"."sales" (
    "id" bigint generated by default as identity not null,
    "first_name" text not null,
    "last_name" text not null,
    "email" text not null,
    "administrator" boolean not null,
    "user_id" uuid not null,
    "avatar" jsonb,
    "disabled" boolean not null default FALSE
);


alter table "public"."sales" enable row level security;

create table "public"."tags" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "color" text not null
);


alter table "public"."tags" enable row level security;

create table "public"."tasks" (
    "id" bigint generated by default as identity not null,
    "contact_id" bigint not null,
    "type" text,
    "text" text,
    "due_date" timestamp with time zone not null,
    "done_date" timestamp with time zone
);


alter table "public"."tasks" enable row level security;

CREATE UNIQUE INDEX companies_pkey ON public.companies USING btree (id);

CREATE UNIQUE INDEX "contactNotes_pkey" ON public."contactNotes" USING btree (id);

CREATE UNIQUE INDEX contacts_pkey ON public.contacts USING btree (id);

CREATE UNIQUE INDEX "dealNotes_pkey" ON public."dealNotes" USING btree (id);

CREATE UNIQUE INDEX deals_pkey ON public.deals USING btree (id);

CREATE UNIQUE INDEX sales_pkey ON public.sales USING btree (id);

CREATE UNIQUE INDEX tags_pkey ON public.tags USING btree (id);

CREATE UNIQUE INDEX tasks_pkey ON public.tasks USING btree (id);

alter table "public"."companies" add constraint "companies_pkey" PRIMARY KEY using index "companies_pkey";

alter table "public"."contactNotes" add constraint "contactNotes_pkey" PRIMARY KEY using index "contactNotes_pkey";

alter table "public"."contacts" add constraint "contacts_pkey" PRIMARY KEY using index "contacts_pkey";

alter table "public"."dealNotes" add constraint "dealNotes_pkey" PRIMARY KEY using index "dealNotes_pkey";

alter table "public"."deals" add constraint "deals_pkey" PRIMARY KEY using index "deals_pkey";

alter table "public"."sales" add constraint "sales_pkey" PRIMARY KEY using index "sales_pkey";

alter table "public"."tags" add constraint "tags_pkey" PRIMARY KEY using index "tags_pkey";

alter table "public"."tasks" add constraint "tasks_pkey" PRIMARY KEY using index "tasks_pkey";

alter table "public"."companies" add constraint "companies_sales_id_fkey" FOREIGN KEY (sales_id) REFERENCES sales(id) not valid;

alter table "public"."companies" validate constraint "companies_sales_id_fkey";

alter table "public"."contactNotes" add constraint "contactNotes_contact_id_fkey" FOREIGN KEY (contact_id) REFERENCES contacts(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."contactNotes" validate constraint "contactNotes_contact_id_fkey";

alter table "public"."contactNotes" add constraint "contactNotes_sales_id_fkey" FOREIGN KEY (sales_id) REFERENCES sales(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."contactNotes" validate constraint "contactNotes_sales_id_fkey";

alter table "public"."contacts" add constraint "contacts_company_id_fkey" FOREIGN KEY (company_id) REFERENCES companies(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."contacts" validate constraint "contacts_company_id_fkey";

alter table "public"."contacts" add constraint "contacts_sales_id_fkey" FOREIGN KEY (sales_id) REFERENCES sales(id) not valid;

alter table "public"."contacts" validate constraint "contacts_sales_id_fkey";

alter table "public"."dealNotes" add constraint "dealNotes_deal_id_fkey" FOREIGN KEY (deal_id) REFERENCES deals(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."dealNotes" validate constraint "dealNotes_deal_id_fkey";

alter table "public"."dealNotes" add constraint "dealNotes_sales_id_fkey" FOREIGN KEY (sales_id) REFERENCES sales(id) not valid;

alter table "public"."dealNotes" validate constraint "dealNotes_sales_id_fkey";

alter table "public"."deals" add constraint "deals_company_id_fkey" FOREIGN KEY (company_id) REFERENCES companies(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."deals" validate constraint "deals_company_id_fkey";

alter table "public"."deals" add constraint "deals_sales_id_fkey" FOREIGN KEY (sales_id) REFERENCES sales(id) not valid;

alter table "public"."deals" validate constraint "deals_sales_id_fkey";

alter table "public"."sales" add constraint "sales_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."sales" validate constraint "sales_user_id_fkey";

alter table "public"."tasks" add constraint "tasks_contact_id_fkey" FOREIGN KEY (contact_id) REFERENCES contacts(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."tasks" validate constraint "tasks_contact_id_fkey";

set check_function_bodies = off;

grant delete on table "public"."companies" to "authenticated";
grant insert on table "public"."companies" to "authenticated";
grant select on table "public"."companies" to "authenticated";
grant update on table "public"."companies" to "authenticated";

grant delete on table "public"."companies" to "service_role";
grant insert on table "public"."companies" to "service_role";
grant references on table "public"."companies" to "service_role";
grant select on table "public"."companies" to "service_role";
grant trigger on table "public"."companies" to "service_role";
grant truncate on table "public"."companies" to "service_role";
grant update on table "public"."companies" to "service_role";

grant delete on table "public"."contactNotes" to "authenticated";
grant insert on table "public"."contactNotes" to "authenticated";
grant select on table "public"."contactNotes" to "authenticated";
grant update on table "public"."contactNotes" to "authenticated";

grant delete on table "public"."contactNotes" to "service_role";
grant insert on table "public"."contactNotes" to "service_role";
grant references on table "public"."contactNotes" to "service_role";
grant select on table "public"."contactNotes" to "service_role";
grant trigger on table "public"."contactNotes" to "service_role";
grant truncate on table "public"."contactNotes" to "service_role";
grant update on table "public"."contactNotes" to "service_role";

grant delete on table "public"."contacts" to "authenticated";
grant insert on table "public"."contacts" to "authenticated";
grant select on table "public"."contacts" to "authenticated";
grant update on table "public"."contacts" to "authenticated";

grant delete on table "public"."contacts" to "service_role";
grant insert on table "public"."contacts" to "service_role";
grant references on table "public"."contacts" to "service_role";
grant select on table "public"."contacts" to "service_role";
grant trigger on table "public"."contacts" to "service_role";
grant truncate on table "public"."contacts" to "service_role";
grant update on table "public"."contacts" to "service_role";

grant delete on table "public"."dealNotes" to "authenticated";
grant insert on table "public"."dealNotes" to "authenticated";
grant select on table "public"."dealNotes" to "authenticated";
grant update on table "public"."dealNotes" to "authenticated";

grant delete on table "public"."dealNotes" to "service_role";
grant insert on table "public"."dealNotes" to "service_role";
grant references on table "public"."dealNotes" to "service_role";
grant select on table "public"."dealNotes" to "service_role";
grant trigger on table "public"."dealNotes" to "service_role";
grant truncate on table "public"."dealNotes" to "service_role";
grant update on table "public"."dealNotes" to "service_role";


grant delete on table "public"."deals" to "authenticated";
grant insert on table "public"."deals" to "authenticated";
grant select on table "public"."deals" to "authenticated";
grant update on table "public"."deals" to "authenticated";

grant delete on table "public"."deals" to "service_role";
grant insert on table "public"."deals" to "service_role";
grant references on table "public"."deals" to "service_role";
grant select on table "public"."deals" to "service_role";
grant trigger on table "public"."deals" to "service_role";
grant truncate on table "public"."deals" to "service_role";
grant update on table "public"."deals" to "service_role";

grant delete on table "public"."sales" to "authenticated";
grant insert on table "public"."sales" to "authenticated";
grant select on table "public"."sales" to "authenticated";
grant update on table "public"."sales" to "authenticated";

grant delete on table "public"."sales" to "service_role";
grant insert on table "public"."sales" to "service_role";
grant references on table "public"."sales" to "service_role";
grant select on table "public"."sales" to "service_role";
grant trigger on table "public"."sales" to "service_role";
grant truncate on table "public"."sales" to "service_role";
grant update on table "public"."sales" to "service_role";

grant delete on table "public"."tags" to "authenticated";
grant insert on table "public"."tags" to "authenticated";
grant select on table "public"."tags" to "authenticated";
grant update on table "public"."tags" to "authenticated";

grant delete on table "public"."tags" to "service_role";
grant insert on table "public"."tags" to "service_role";
grant references on table "public"."tags" to "service_role";
grant select on table "public"."tags" to "service_role";
grant trigger on table "public"."tags" to "service_role";
grant truncate on table "public"."tags" to "service_role";
grant update on table "public"."tags" to "service_role";

grant delete on table "public"."tasks" to "authenticated";
grant insert on table "public"."tasks" to "authenticated";
grant select on table "public"."tasks" to "authenticated";
grant update on table "public"."tasks" to "authenticated";

grant delete on table "public"."tasks" to "service_role";
grant insert on table "public"."tasks" to "service_role";
grant references on table "public"."tasks" to "service_role";
grant select on table "public"."tasks" to "service_role";
grant trigger on table "public"."tasks" to "service_role";
grant truncate on table "public"."tasks" to "service_role";
grant update on table "public"."tasks" to "service_role";

create policy "Enable insert for authenticated users only"
on "public"."companies"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on "public"."companies"
as permissive
for select
to authenticated
using (true);


create policy "Enable update for authenticated users only"
on "public"."companies"
as permissive
for update
to authenticated
using (true)
with check (true);


create policy "Enable insert for authenticated users only"
on "public"."contactNotes"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on "public"."contactNotes"
as permissive
for select
to authenticated
using (true);


create policy "Enable insert for authenticated users only"
on "public"."contacts"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on "public"."contacts"
as permissive
for select
to authenticated
using (true);


create policy "Enable update for authenticated users only"
on "public"."contacts"
as permissive
for update
to authenticated
using (true)
with check (true);


create policy "Enable insert for authenticated users only"
on "public"."dealNotes"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on "public"."dealNotes"
as permissive
for select
to authenticated
using (true);


create policy "Enable insert for authenticated users only"
on "public"."deals"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on "public"."deals"
as permissive
for select
to authenticated
using (true);


create policy "Enable update for authenticated users only"
on "public"."deals"
as permissive
for update
to authenticated
using (true)
with check (true);


create policy "Enable insert for authenticated users only"
on "public"."sales"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable update for authenticated users only"
on "public"."sales"
as permissive
for update
to authenticated
using (true)
with check (true);


create policy "Enable read access for authenticated users"
on "public"."sales"
as permissive
for select
to authenticated
using (true);


create policy "Enable insert for authenticated users only"
on "public"."tags"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on "public"."tags"
as permissive
for select
to authenticated
using (true);


create policy "Enable insert for authenticated users only"
on "public"."tasks"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for authenticated users"
on "public"."tasks"
as permissive
for select
to authenticated
using (true);


create policy "Company Delete Policy"
on "public"."companies"
as permissive
for delete
to authenticated
using (true);


create policy "Contact Notes Delete Policy"
on "public"."contactNotes"
as permissive
for delete
to authenticated
using (true);


create policy "Contact Notes Update policy"
on "public"."contactNotes"
as permissive
for update
to authenticated
using (true);


create policy "Contact Delete Policy"
on "public"."contacts"
as permissive
for delete
to authenticated
using (true);


create policy "Deal Notes Delete Policy"
on "public"."dealNotes"
as permissive
for delete
to authenticated
using (true);


create policy "Deal Notes Update Policy"
on "public"."dealNotes"
as permissive
for update
to authenticated
using (true);


create policy "Deals Delete Policy"
on "public"."deals"
as permissive
for delete
to authenticated
using (true);


create policy "Task Delete Policy"
on "public"."tasks"
as permissive
for delete
to authenticated
using (true);


create policy "Task Update Policy"
on "public"."tasks"
as permissive
for update
to authenticated
using (true);


-- Use Postgres to create a bucket.

insert into storage.buckets
  (id, name, public)
values
  ('attachments', 'attachments', true);

CREATE POLICY "Attachments 1mt4rzk_0" ON storage.objects FOR SELECT TO authenticated USING (bucket_id = 'attachments');
CREATE POLICY "Attachments 1mt4rzk_1" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = 'attachments');
CREATE POLICY "Attachments 1mt4rzk_3" ON storage.objects FOR DELETE TO authenticated USING (bucket_id = 'attachments');

-- Use Postgres to create views for companies.

create view "public"."companies_summary" as
select 
    c.*,
    count(distinct d.id) as nb_deals,
    count(distinct co.id) as nb_contacts
from 
    "public"."companies" c
left join 
    "public"."deals" d on c.id = d.company_id
left join 
    "public"."contacts" co on c.id = co.company_id
group by 
    c.id;
    
-- Use Postgres to create views for contacts.

create view "public"."contacts_summary" as
select 
    co.*,
    c.name as company_name,
    count(distinct t.id) as nb_tasks
from
    "public"."contacts" co
left join
    "public"."tasks" t on co.id = t.contact_id
left join
    "public"."companies" c on co.company_id = c.id
group by
    co.id, c.name;


