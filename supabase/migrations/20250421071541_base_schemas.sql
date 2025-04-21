create type "public"."task_priority" as enum ('low', 'medium', 'high');

create type "public"."task_status" as enum ('not_started', 'in_progress', 'completed');

create table "public"."profiles" (
    "id" uuid not null,
    "display_name" text,
    "avatar_url" text,
    "theme" text default 'light'::text,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


alter table "public"."profiles" enable row level security;

create table "public"."tags" (
    "id" uuid not null default uuid_generate_v4(),
    "user_id" uuid not null,
    "name" text not null,
    "color" text not null default '#808080'::text,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."tags" enable row level security;

create table "public"."task_tags" (
    "task_id" uuid not null,
    "tag_id" uuid not null
);


alter table "public"."task_tags" enable row level security;

create table "public"."tasks" (
    "id" uuid not null default uuid_generate_v4(),
    "user_id" uuid not null,
    "title" text not null,
    "description" text,
    "due_date" timestamp with time zone,
    "priority" task_priority default 'medium'::task_priority,
    "status" task_status default 'not_started'::task_status,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);


alter table "public"."tasks" enable row level security;

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX tags_pkey ON public.tags USING btree (id);

CREATE UNIQUE INDEX task_tags_pkey ON public.task_tags USING btree (task_id, tag_id);

CREATE UNIQUE INDEX tasks_pkey ON public.tasks USING btree (id);

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."tags" add constraint "tags_pkey" PRIMARY KEY using index "tags_pkey";

alter table "public"."task_tags" add constraint "task_tags_pkey" PRIMARY KEY using index "task_tags_pkey";

alter table "public"."tasks" add constraint "tasks_pkey" PRIMARY KEY using index "tasks_pkey";

alter table "public"."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_id_fkey";

alter table "public"."tags" add constraint "tags_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."tags" validate constraint "tags_user_id_fkey";

alter table "public"."task_tags" add constraint "task_tags_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE not valid;

alter table "public"."task_tags" validate constraint "task_tags_tag_id_fkey";

alter table "public"."task_tags" add constraint "task_tags_task_id_fkey" FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE not valid;

alter table "public"."task_tags" validate constraint "task_tags_task_id_fkey";

alter table "public"."tasks" add constraint "tasks_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."tasks" validate constraint "tasks_user_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  INSERT INTO public.profiles (id, display_name)
  VALUES (new.id, new.email);
  RETURN new;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.update_updated_at_column()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$function$
;

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";

grant delete on table "public"."tags" to "anon";

grant insert on table "public"."tags" to "anon";

grant references on table "public"."tags" to "anon";

grant select on table "public"."tags" to "anon";

grant trigger on table "public"."tags" to "anon";

grant truncate on table "public"."tags" to "anon";

grant update on table "public"."tags" to "anon";

grant delete on table "public"."tags" to "authenticated";

grant insert on table "public"."tags" to "authenticated";

grant references on table "public"."tags" to "authenticated";

grant select on table "public"."tags" to "authenticated";

grant trigger on table "public"."tags" to "authenticated";

grant truncate on table "public"."tags" to "authenticated";

grant update on table "public"."tags" to "authenticated";

grant delete on table "public"."tags" to "service_role";

grant insert on table "public"."tags" to "service_role";

grant references on table "public"."tags" to "service_role";

grant select on table "public"."tags" to "service_role";

grant trigger on table "public"."tags" to "service_role";

grant truncate on table "public"."tags" to "service_role";

grant update on table "public"."tags" to "service_role";

grant delete on table "public"."task_tags" to "anon";

grant insert on table "public"."task_tags" to "anon";

grant references on table "public"."task_tags" to "anon";

grant select on table "public"."task_tags" to "anon";

grant trigger on table "public"."task_tags" to "anon";

grant truncate on table "public"."task_tags" to "anon";

grant update on table "public"."task_tags" to "anon";

grant delete on table "public"."task_tags" to "authenticated";

grant insert on table "public"."task_tags" to "authenticated";

grant references on table "public"."task_tags" to "authenticated";

grant select on table "public"."task_tags" to "authenticated";

grant trigger on table "public"."task_tags" to "authenticated";

grant truncate on table "public"."task_tags" to "authenticated";

grant update on table "public"."task_tags" to "authenticated";

grant delete on table "public"."task_tags" to "service_role";

grant insert on table "public"."task_tags" to "service_role";

grant references on table "public"."task_tags" to "service_role";

grant select on table "public"."task_tags" to "service_role";

grant trigger on table "public"."task_tags" to "service_role";

grant truncate on table "public"."task_tags" to "service_role";

grant update on table "public"."task_tags" to "service_role";

grant delete on table "public"."tasks" to "anon";

grant insert on table "public"."tasks" to "anon";

grant references on table "public"."tasks" to "anon";

grant select on table "public"."tasks" to "anon";

grant trigger on table "public"."tasks" to "anon";

grant truncate on table "public"."tasks" to "anon";

grant update on table "public"."tasks" to "anon";

grant delete on table "public"."tasks" to "authenticated";

grant insert on table "public"."tasks" to "authenticated";

grant references on table "public"."tasks" to "authenticated";

grant select on table "public"."tasks" to "authenticated";

grant trigger on table "public"."tasks" to "authenticated";

grant truncate on table "public"."tasks" to "authenticated";

grant update on table "public"."tasks" to "authenticated";

grant delete on table "public"."tasks" to "service_role";

grant insert on table "public"."tasks" to "service_role";

grant references on table "public"."tasks" to "service_role";

grant select on table "public"."tasks" to "service_role";

grant trigger on table "public"."tasks" to "service_role";

grant truncate on table "public"."tasks" to "service_role";

grant update on table "public"."tasks" to "service_role";

create policy "Users can only insert their own profile"
on "public"."profiles"
as permissive
for insert
to public
with check ((auth.uid() = id));


create policy "Users can only update their own profile"
on "public"."profiles"
as permissive
for update
to public
using ((auth.uid() = id));


create policy "Users can see all profiles"
on "public"."profiles"
as permissive
for select
to public
using (true);


create policy "Users can only delete their own tags"
on "public"."tags"
as permissive
for delete
to public
using ((auth.uid() = user_id));


create policy "Users can only insert their own tags"
on "public"."tags"
as permissive
for insert
to public
with check ((auth.uid() = user_id));


create policy "Users can only see their own tags"
on "public"."tags"
as permissive
for select
to public
using ((auth.uid() = user_id));


create policy "Users can only update their own tags"
on "public"."tags"
as permissive
for update
to public
using ((auth.uid() = user_id));


create policy "Users can only delete their own task_tags"
on "public"."task_tags"
as permissive
for delete
to public
using ((EXISTS ( SELECT 1
   FROM tasks
  WHERE ((tasks.id = task_tags.task_id) AND (tasks.user_id = auth.uid())))));


create policy "Users can only insert their own task_tags"
on "public"."task_tags"
as permissive
for insert
to public
with check ((EXISTS ( SELECT 1
   FROM tasks
  WHERE ((tasks.id = task_tags.task_id) AND (tasks.user_id = auth.uid())))));


create policy "Users can only see their own task_tags"
on "public"."task_tags"
as permissive
for select
to public
using ((EXISTS ( SELECT 1
   FROM tasks
  WHERE ((tasks.id = task_tags.task_id) AND (tasks.user_id = auth.uid())))));


create policy "Users can only delete their own tasks"
on "public"."tasks"
as permissive
for delete
to public
using ((auth.uid() = user_id));


create policy "Users can only insert their own tasks"
on "public"."tasks"
as permissive
for insert
to public
with check ((auth.uid() = user_id));


create policy "Users can only see their own tasks"
on "public"."tasks"
as permissive
for select
to public
using ((auth.uid() = user_id));


create policy "Users can only update their own tasks"
on "public"."tasks"
as permissive
for update
to public
using ((auth.uid() = user_id));


CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON public.tasks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();



