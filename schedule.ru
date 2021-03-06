PGDMP     !    *                 x            fefu "   10.11 (Ubuntu 10.11-1.pgdg18.04+1)     12.1 (Ubuntu 12.1-1.pgdg18.04+1) �    z           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            {           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            |           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            }           1262    16667    fefu    DATABASE     v   CREATE DATABASE fefu WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';
    DROP DATABASE fefu;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            ~           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3                        1255    16671    _final_median(numeric[])    FUNCTION     %  CREATE FUNCTION public._final_median(numeric[]) RETURNS numeric
    LANGUAGE sql IMMUTABLE
    AS $_$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$_$;
 /   DROP FUNCTION public._final_median(numeric[]);
       public          postgres    false    3                       1255    16672    add_em(integer, integer)    FUNCTION     t   CREATE FUNCTION public.add_em(integer, integer) RETURNS integer
    LANGUAGE sql
    AS $_$    SELECT $1 + $2;
$_$;
 /   DROP FUNCTION public.add_em(integer, integer);
       public          postgres    false    3                       1255    16673    minus(integer, integer)    FUNCTION     n   CREATE FUNCTION public.minus(integer, integer) RETURNS integer
    LANGUAGE sql
    AS $_$SELECT $1 - $2
$_$;
 .   DROP FUNCTION public.minus(integer, integer);
       public          postgres    false    3                       1255    16674    new_group()    FUNCTION     Y  CREATE FUNCTION public.new_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	DECLARE
		new_id integer;
		new_name varchar(255);
  BEGIN
        IF NEW."group_id" IS NULL THEN
			new_id := ((SELECT "id" FROM "task_triggers"."groups" ORDER BY "id" DESC LIMIT 1) + 1);
			new_name := (SELECT "name" FROM "task_triggers"."groups" ORDER BY "name" LIMIT 1);
			raise notice 'Value: %', new_id;
			raise notice 'Value: %', new_name;
            INSERT INTO "task_triggers"."groups" ("name") VALUES(concat(new_name, new_id));
      		NEW."group_id" := new_id;
        END IF;
    RETURN NEW;
  END;

$$;
 "   DROP FUNCTION public.new_group();
       public          postgres    false    3                       1255    16677    median(numeric) 	   AGGREGATE     �   CREATE AGGREGATE public.median(numeric) (
    SFUNC = array_append,
    STYPE = numeric[],
    INITCOND = '{}',
    FINALFUNC = public._final_median
);
 '   DROP AGGREGATE public.median(numeric);
       public          postgres    false    256    3            �            1259    16710 
   Classrooms    TABLE     j   CREATE TABLE public."Classrooms" (
    id integer NOT NULL,
    "Name" character varying(255) NOT NULL
);
     DROP TABLE public."Classrooms";
       public            postgres    false    3            �            1259    16713 
   Group_List    TABLE     �   CREATE TABLE public."Group_List" (
    id integer NOT NULL,
    "Student_id" integer NOT NULL,
    "Group_id" integer NOT NULL,
    "Strat_date" date NOT NULL,
    "End_date" date NOT NULL,
    "Active" boolean NOT NULL
);
     DROP TABLE public."Group_List";
       public            postgres    false    3            �            1259    16716    Group_List_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Group_List_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Group_List_id_seq";
       public          postgres    false    3    210                       0    0    Group_List_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Group_List_id_seq" OWNED BY public."Group_List".id;
          public          postgres    false    211            �            1259    16718    Groups    TABLE     f   CREATE TABLE public."Groups" (
    id integer NOT NULL,
    "Name" character varying(255) NOT NULL
);
    DROP TABLE public."Groups";
       public            postgres    false    3            �            1259    16721    Groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Groups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Groups_id_seq";
       public          postgres    false    3    212            �           0    0    Groups_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Groups_id_seq" OWNED BY public."Groups".id;
          public          postgres    false    213            �            1259    16723    Journal    TABLE     �   CREATE TABLE public."Journal" (
    id integer NOT NULL,
    "Student_id" integer NOT NULL,
    "Schedule_id" integer NOT NULL,
    "Visited" boolean NOT NULL
);
    DROP TABLE public."Journal";
       public            postgres    false    3            �            1259    16726    Journal_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Journal_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Journal_id_seq";
       public          postgres    false    3    214            �           0    0    Journal_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Journal_id_seq" OWNED BY public."Journal".id;
          public          postgres    false    215            �            1259    16728    Subjects    TABLE     h   CREATE TABLE public."Subjects" (
    id integer NOT NULL,
    "Name" character varying(255) NOT NULL
);
    DROP TABLE public."Subjects";
       public            postgres    false    3            �            1259    16731    Lesson_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Lesson_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Lesson_id_seq";
       public          postgres    false    3    216            �           0    0    Lesson_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Lesson_id_seq" OWNED BY public."Subjects".id;
          public          postgres    false    217            �            1259    16733    Marks    TABLE     �   CREATE TABLE public."Marks" (
    id integer NOT NULL,
    student_id integer NOT NULL,
    task_id integer NOT NULL,
    mark smallint DEFAULT 0
);
    DROP TABLE public."Marks";
       public            postgres    false    3            �            1259    16737    Pairs    TABLE     �   CREATE TABLE public."Pairs" (
    id integer NOT NULL,
    "Start_time" time without time zone NOT NULL,
    "End_time" time without time zone NOT NULL
);
    DROP TABLE public."Pairs";
       public            postgres    false    3            �            1259    16740    Pairs_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Pairs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Pairs_id_seq";
       public          postgres    false    219    3            �           0    0    Pairs_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Pairs_id_seq" OWNED BY public."Pairs".id;
          public          postgres    false    220            �            1259    16742 
   Professors    TABLE     �   CREATE TABLE public."Professors" (
    id integer NOT NULL,
    "First_Name" character varying(255) NOT NULL,
    "Last_Name" character varying(255) NOT NULL,
    "Middle_Name" character varying(255)
);
     DROP TABLE public."Professors";
       public            postgres    false    3            �            1259    16748    Professors_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Professors_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Professors_id_seq";
       public          postgres    false    3    221            �           0    0    Professors_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Professors_id_seq" OWNED BY public."Professors".id;
          public          postgres    false    222            �            1259    16750    Schedule    TABLE       CREATE TABLE public."Schedule" (
    id integer NOT NULL,
    "Group_id" integer NOT NULL,
    "Lesson_id" integer NOT NULL,
    "Professor_id" integer NOT NULL,
    "Pair_id" integer NOT NULL,
    "Date" date NOT NULL,
    "Classroom_id" integer NOT NULL
);
    DROP TABLE public."Schedule";
       public            postgres    false    3            �            1259    16753    Schedule_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Schedule_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Schedule_id_seq";
       public          postgres    false    3    223            �           0    0    Schedule_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Schedule_id_seq" OWNED BY public."Schedule".id;
          public          postgres    false    224            �            1259    16755    Student_book    TABLE     �   CREATE TABLE public."Student_book" (
    id integer NOT NULL,
    "Student_id" integer NOT NULL,
    "Lesson_id" integer NOT NULL,
    "Semester" integer NOT NULL,
    "Mark" integer
);
 "   DROP TABLE public."Student_book";
       public            postgres    false    3            �            1259    16758    Student_book_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Student_book_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Student_book_id_seq";
       public          postgres    false    3    225            �           0    0    Student_book_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Student_book_id_seq" OWNED BY public."Student_book".id;
          public          postgres    false    226            �            1259    16760    Students    TABLE     �   CREATE TABLE public."Students" (
    id integer NOT NULL,
    "First_Name" character varying(255) NOT NULL,
    "Last_Name" character varying(255) NOT NULL,
    "Group_id" integer NOT NULL,
    "Middle_Name" character varying(255)
);
    DROP TABLE public."Students";
       public            postgres    false    3            �            1259    16766    Students_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Students_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Students_id_seq";
       public          postgres    false    227    3            �           0    0    Students_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Students_id_seq" OWNED BY public."Students".id;
          public          postgres    false    228            �            1259    16768    Tasks    TABLE     k   CREATE TABLE public."Tasks" (
    id integer NOT NULL,
    subject_id integer NOT NULL,
    "Text" text
);
    DROP TABLE public."Tasks";
       public            postgres    false    3            �            1259    16774    attendance_log    VIEW     }  CREATE VIEW public.attendance_log AS
 SELECT concat(t2."First_Name", ' ', t2."Last_Name", ' ', t2."Middle_Name") AS student_name,
    t3."Date" AS date,
    concat(t5."Start_time", '-', t5."End_time") AS "time",
    t4."Name" AS lesson_name,
        CASE
            WHEN (t1."Visited" = true) THEN '+'::text
            ELSE '-'::text
        END AS "case"
   FROM ((((public."Journal" t1
     JOIN public."Students" t2 ON ((t1."Student_id" = t2.id)))
     JOIN public."Schedule" t3 ON ((t1."Schedule_id" = t3.id)))
     JOIN public."Subjects" t4 ON ((t3."Lesson_id" = t4.id)))
     JOIN public."Pairs" t5 ON ((t3."Pair_id" = t5.id)));
 !   DROP VIEW public.attendance_log;
       public          postgres    false    227    214    214    214    216    216    219    219    219    223    223    223    223    227    227    227    3            �            1259    16779    classroom_id_seq    SEQUENCE     �   CREATE SEQUENCE public.classroom_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.classroom_id_seq;
       public          postgres    false    3    209            �           0    0    classroom_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.classroom_id_seq OWNED BY public."Classrooms".id;
          public          postgres    false    231            �            1259    16781    full_schedule    VIEW       CREATE VIEW public.full_schedule AS
 SELECT t1."Date",
    concat(t4."Start_time", '-', t4."End_time") AS "time",
    t2."Name" AS group_name,
    t3."Name" AS subject_name,
    t5."Name" AS classroom,
    concat(t6."First_Name", ' ', t6."Last_Name", ' ', t6."Middle_Name") AS professor_name
   FROM (((((public."Schedule" t1
     JOIN public."Groups" t2 ON ((t1."Group_id" = t2.id)))
     JOIN public."Subjects" t3 ON ((t1."Lesson_id" = t3.id)))
     JOIN public."Pairs" t4 ON ((t1."Pair_id" = t4.id)))
     JOIN public."Classrooms" t5 ON ((t1."Classroom_id" = t5.id)))
     JOIN public."Professors" t6 ON ((t1."Professor_id" = t6.id)));
     DROP VIEW public.full_schedule;
       public          postgres    false    223    223    223    223    223    223    221    221    221    221    219    219    219    216    216    212    212    209    209    3            �            1259    16786    mark_id_seq    SEQUENCE     �   CREATE SEQUENCE public.mark_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.mark_id_seq;
       public          postgres    false    3    218            �           0    0    mark_id_seq    SEQUENCE OWNED BY     >   ALTER SEQUENCE public.mark_id_seq OWNED BY public."Marks".id;
          public          postgres    false    233            �            1259    16788    mark_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.mark_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.mark_student_id_seq;
       public          postgres    false    3    218            �           0    0    mark_student_id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.mark_student_id_seq OWNED BY public."Marks".student_id;
          public          postgres    false    234            �            1259    16790    mark_task_id_seq    SEQUENCE     �   CREATE SEQUENCE public.mark_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.mark_task_id_seq;
       public          postgres    false    3    218            �           0    0    mark_task_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.mark_task_id_seq OWNED BY public."Marks".task_id;
          public          postgres    false    235            �            1259    16792    tasks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.tasks_id_seq;
       public          postgres    false    3    229            �           0    0    tasks_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.tasks_id_seq OWNED BY public."Tasks".id;
          public          postgres    false    236            �            1259    16794    tasks_subject_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tasks_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.tasks_subject_id_seq;
       public          postgres    false    3    229            �           0    0    tasks_subject_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tasks_subject_id_seq OWNED BY public."Tasks".subject_id;
          public          postgres    false    237            �            1259    17017    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(30) NOT NULL,
    password character varying(32) NOT NULL,
    sign_up_date date
);
    DROP TABLE public.users;
       public            postgres    false    3            �            1259    17020    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    254    3            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    255            �            1259    17012 
   view_marks    VIEW     w  CREATE VIEW public.view_marks AS
 SELECT concat(t3."First_Name", ' ', t3."Last_Name", ' ', t3."Middle_Name") AS student_name,
    t4."Name",
    t2."Text",
    t1.mark
   FROM (((public."Marks" t1
     JOIN public."Tasks" t2 ON ((t1.task_id = t2.id)))
     JOIN public."Students" t3 ON ((t1.student_id = t3.id)))
     JOIN public."Subjects" t4 ON ((t4.id = t2.subject_id)));
    DROP VIEW public.view_marks;
       public          postgres    false    218    216    218    218    227    227    227    227    229    229    229    216    3            �            1259    16796 $   view_of_excellent_students_task_№3    VIEW       CREATE VIEW public."view_of_excellent_students_task_№3" AS
 SELECT concat(t2."First_Name", ' ', t2."Last_Name", ' ', t2."Middle_Name") AS student_name,
        CASE
            WHEN (((sum(
            CASE
                WHEN (t1.mark = 5) THEN 1
                ELSE 0
            END))::double precision / (count(t1.mark))::double precision) >= (0.75)::double precision) THEN concat('Отличник: ', ((sum(t1.mark))::double precision / (count(t1.mark))::double precision))
            ELSE NULL::text
        END AS avg_mark
   FROM (public."Marks" t1
     JOIN public."Students" t2 ON ((t1.student_id = t2.id)))
  WHERE (NOT (t1.student_id IN ( SELECT DISTINCT t3.id
           FROM (public."Students" t3
             JOIN public."Marks" t4 ON ((t4.student_id = t3.id)))
          WHERE (t4.mark = 3))))
  GROUP BY (concat(t2."First_Name", ' ', t2."Last_Name", ' ', t2."Middle_Name"))
 HAVING (
        CASE
            WHEN (((sum(
            CASE
                WHEN (t1.mark = 5) THEN 1
                ELSE 0
            END))::double precision / (count(t1.mark))::double precision) >= (0.75)::double precision) THEN concat('Отличник: ', ((sum(t1.mark))::double precision / (count(t1.mark))::double precision))
            ELSE NULL::text
        END IS NOT NULL);
 9   DROP VIEW public."view_of_excellent_students_task_№3";
       public          postgres    false    227    227    227    227    218    218    3            �            1259    16801 .   view_of_median_marks_and_rnd_student_task_№4    VIEW     6  CREATE VIEW public."view_of_median_marks_and_rnd_student_task_№4" AS
 SELECT DISTINCT ON (t4."Name") t4."Name",
    public.median((t1.mark)::numeric) AS median,
    concat(t2."First_Name", ' ', t2."Last_Name", ' ', t2."Middle_Name") AS student
   FROM (((public."Marks" t1
     JOIN public."Students" t2 ON ((t1.student_id = t2.id)))
     JOIN public."Tasks" t3 ON ((t1.task_id = t3.id)))
     JOIN public."Subjects" t4 ON ((t3.subject_id = t4.id)))
  GROUP BY t4."Name", (concat(t2."First_Name", ' ', t2."Last_Name", ' ', t2."Middle_Name"))
  ORDER BY t4."Name";
 C   DROP VIEW public."view_of_median_marks_and_rnd_student_task_№4";
       public          postgres    false    229    771    216    216    218    218    218    227    227    227    227    229    3            �            1259    16806    view_of_truant_students    VIEW     v  CREATE VIEW public.view_of_truant_students AS
 SELECT concat(t1."First_Name", ' ', t1."Last_Name", ' ', t1."Middle_Name") AS concat,
        CASE
            WHEN (((count(t2."Visited") FILTER (WHERE (t2."Visited" = true)))::double precision / (count(t2."Visited"))::double precision) > (0.5)::double precision) THEN 'Не злостный прогульщик'::text
            ELSE 'Злостный прогульщик'::text
        END AS is_truant
   FROM (public."Students" t1
     JOIN public."Journal" t2 ON ((t1.id = t2."Student_id")))
  GROUP BY (concat(t1."First_Name", ' ', t1."Last_Name", ' ', t1."Middle_Name"));
 *   DROP VIEW public.view_of_truant_students;
       public          postgres    false    227    227    214    214    227    227    3            �            1259    16811 (   view_of_truant_students_task_edited_№1    VIEW     �  CREATE VIEW public."view_of_truant_students_task_edited_№1" AS
 SELECT concat(t1."First_Name", ' ', t1."Last_Name", ' ', t1."Middle_Name") AS concat,
    t1.id,
    t4."Name" AS subject_name,
        CASE
            WHEN (((count(t2."Visited") FILTER (WHERE (t2."Visited" = true)))::double precision / (count(t2."Visited"))::double precision) < (0.5)::double precision) THEN 'Прогульщик'::text
            WHEN (((count(t2."Visited") FILTER (WHERE (t2."Visited" = true)))::double precision / (count(t2."Visited"))::double precision) = (0.5)::double precision) THEN '50:50'::text
            ELSE NULL::text
        END AS is_truant
   FROM (((public."Students" t1
     JOIN public."Journal" t2 ON ((t1.id = t2."Student_id")))
     JOIN public."Schedule" t3 ON ((t2."Schedule_id" = t3.id)))
     JOIN public."Subjects" t4 ON ((t3."Lesson_id" = t4.id)))
  GROUP BY (concat(t1."First_Name", ' ', t1."Last_Name", ' ', t1."Middle_Name")), t1.id, t4."Name"
 HAVING (((count(t2."Visited") FILTER (WHERE (t2."Visited" = true)))::double precision / (count(t2."Visited"))::double precision) <= (0.5)::double precision)
  ORDER BY (concat(t1."First_Name", ' ', t1."Last_Name", ' ', t1."Middle_Name"));
 =   DROP VIEW public."view_of_truant_students_task_edited_№1";
       public          postgres    false    214    214    216    214    216    223    223    227    227    227    227    3            �            1259    16816 !   view_of_truant_students_task_№1    VIEW     M  CREATE VIEW public."view_of_truant_students_task_№1" WITH (security_barrier='false') AS
 SELECT concat(t1."First_Name", ' ', t1."Last_Name", ' ', t1."Middle_Name") AS concat,
    t4."Name" AS subject_name,
        CASE
            WHEN (((count(t2."Visited") FILTER (WHERE (t2."Visited" = true)))::double precision / (count(t2."Visited"))::double precision) > (0.5)::double precision) THEN 'Прилежный студент'::text
            WHEN (((count(t2."Visited") FILTER (WHERE (t2."Visited" = true)))::double precision / (count(t2."Visited"))::double precision) = (0.5)::double precision) THEN '50:50'::text
            ELSE 'Злостный прогульщик'::text
        END AS is_truant
   FROM (((public."Students" t1
     JOIN public."Journal" t2 ON ((t1.id = t2."Student_id")))
     JOIN public."Schedule" t3 ON ((t2."Schedule_id" = t3.id)))
     JOIN public."Subjects" t4 ON ((t3."Lesson_id" = t4.id)))
  GROUP BY (concat(t1."First_Name", ' ', t1."Last_Name", ' ', t1."Middle_Name")), t4."Name"
  ORDER BY (concat(t1."First_Name", ' ', t1."Last_Name", ' ', t1."Middle_Name"));
 6   DROP VIEW public."view_of_truant_students_task_№1";
       public          postgres    false    216    214    227    227    227    227    214    223    223    216    214    3            �            1259    16821 -   view_of_truant_subject_count_task_edited_№2    VIEW     �  CREATE VIEW public."view_of_truant_subject_count_task_edited_№2" AS
 SELECT t3."Name",
    sum(
        CASE
            WHEN (t1."Visited" = false) THEN 1
            ELSE 0
        END) AS truant_cnt
   FROM ((public."Journal" t1
     JOIN public."Schedule" t2 ON ((t1."Schedule_id" = t2.id)))
     JOIN public."Subjects" t3 ON ((t2."Lesson_id" = t3.id)))
  WHERE (t1."Student_id" IN ( SELECT t1_1.student_id
           FROM ( SELECT concat(t1_2."First_Name", ' ', t1_2."Last_Name", ' ', t1_2."Middle_Name") AS concat,
                    t1_2.id AS student_id,
                    t4."Name" AS subject_name,
                        CASE
                            WHEN (((count(t2_1."Visited") FILTER (WHERE (t2_1."Visited" = true)))::double precision / (count(t2_1."Visited"))::double precision) < (0.5)::double precision) THEN 'Прогульщик'::text
                            WHEN (((count(t2_1."Visited") FILTER (WHERE (t2_1."Visited" = true)))::double precision / (count(t2_1."Visited"))::double precision) = (0.5)::double precision) THEN '50:50'::text
                            ELSE NULL::text
                        END AS is_truant
                   FROM (((public."Students" t1_2
                     JOIN public."Journal" t2_1 ON ((t1_2.id = t2_1."Student_id")))
                     JOIN public."Schedule" t3_1 ON ((t2_1."Schedule_id" = t3_1.id)))
                     JOIN public."Subjects" t4 ON ((t3_1."Lesson_id" = t4.id)))
                  GROUP BY (concat(t1_2."First_Name", ' ', t1_2."Last_Name", ' ', t1_2."Middle_Name")), t1_2.id, t4."Name"
                 HAVING (((count(t2_1."Visited") FILTER (WHERE (t2_1."Visited" = true)))::double precision / (count(t2_1."Visited"))::double precision) <= (0.5)::double precision)
                  ORDER BY (concat(t1_2."First_Name", ' ', t1_2."Last_Name", ' ', t1_2."Middle_Name"))) t1_1))
  GROUP BY t3."Name"
  ORDER BY (sum(
        CASE
            WHEN (t1."Visited" = false) THEN 1
            ELSE 0
        END)) DESC;
 B   DROP VIEW public."view_of_truant_subject_count_task_edited_№2";
       public          postgres    false    216    227    227    214    214    227    227    223    214    216    223    3            �            1259    16826 &   view_of_truant_subject_count_task_№2    VIEW     �  CREATE VIEW public."view_of_truant_subject_count_task_№2" AS
 SELECT t3."Name",
    count(t1."Visited") FILTER (WHERE (t1."Visited" = true)) AS visits_count,
    count(t1."Visited") FILTER (WHERE (t1."Visited" = false)) AS truant_count
   FROM ((public."Journal" t1
     JOIN public."Schedule" t2 ON ((t1."Schedule_id" = t2.id)))
     JOIN public."Subjects" t3 ON ((t2."Lesson_id" = t3.id)))
  GROUP BY t3."Name"
  ORDER BY (count(t1."Visited") FILTER (WHERE (t1."Visited" = false))) DESC;
 ;   DROP VIEW public."view_of_truant_subject_count_task_№2";
       public          postgres    false    214    223    214    216    216    223    3            �            1259    17003    view_schedule    VIEW     8  CREATE VIEW public.view_schedule AS
 SELECT concat(t5."Start_time", '-', t5."End_time") AS "Pair_time",
    t1."Date",
    t6."Name" AS "Classroom",
    t3."Name" AS "Subject",
    concat(t4."First_Name", ' ', t4."Last_Name", ' ', t4."Middle_Name") AS "Professor_name",
    t2."Name"
   FROM (((((public."Schedule" t1
     JOIN public."Groups" t2 ON ((t1."Group_id" = t2.id)))
     JOIN public."Subjects" t3 ON ((t1."Lesson_id" = t3.id)))
     JOIN public."Professors" t4 ON ((t1."Professor_id" = t4.id)))
     JOIN public."Pairs" t5 ON ((t1."Pair_id" = t5.id)))
     JOIN public."Classrooms" t6 ON ((t1."Classroom_id" = t6.id)))
  WHERE (((t1."Date" >= '2019-09-20'::date) AND (t1."Date" <= '2019-09-24'::date)) AND ((t2."Name")::text = 'ШЦЭ'::text))
  ORDER BY t1."Date", (concat(t5."Start_time", '-', t5."End_time"));
     DROP VIEW public.view_schedule;
       public          postgres    false    221    221    221    221    219    223    223    223    223    223    223    219    216    216    212    212    209    209    219    3            �            1259    17008 
   view_tasks    VIEW     �   CREATE VIEW public.view_tasks AS
 SELECT t1.id,
    t2."Name",
    t1."Text"
   FROM (public."Tasks" t1
     JOIN public."Subjects" t2 ON ((t1.subject_id = t2.id)));
    DROP VIEW public.view_tasks;
       public          postgres    false    216    229    216    229    229    3            �           2604    16853    Classrooms id    DEFAULT     o   ALTER TABLE ONLY public."Classrooms" ALTER COLUMN id SET DEFAULT nextval('public.classroom_id_seq'::regclass);
 >   ALTER TABLE public."Classrooms" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    209            �           2604    16854    Group_List id    DEFAULT     r   ALTER TABLE ONLY public."Group_List" ALTER COLUMN id SET DEFAULT nextval('public."Group_List_id_seq"'::regclass);
 >   ALTER TABLE public."Group_List" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210            �           2604    16855 	   Groups id    DEFAULT     j   ALTER TABLE ONLY public."Groups" ALTER COLUMN id SET DEFAULT nextval('public."Groups_id_seq"'::regclass);
 :   ALTER TABLE public."Groups" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212            �           2604    16856 
   Journal id    DEFAULT     l   ALTER TABLE ONLY public."Journal" ALTER COLUMN id SET DEFAULT nextval('public."Journal_id_seq"'::regclass);
 ;   ALTER TABLE public."Journal" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214            �           2604    16857    Marks id    DEFAULT     e   ALTER TABLE ONLY public."Marks" ALTER COLUMN id SET DEFAULT nextval('public.mark_id_seq'::regclass);
 9   ALTER TABLE public."Marks" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    218            �           2604    16858    Marks student_id    DEFAULT     u   ALTER TABLE ONLY public."Marks" ALTER COLUMN student_id SET DEFAULT nextval('public.mark_student_id_seq'::regclass);
 A   ALTER TABLE public."Marks" ALTER COLUMN student_id DROP DEFAULT;
       public          postgres    false    234    218            �           2604    16859    Marks task_id    DEFAULT     o   ALTER TABLE ONLY public."Marks" ALTER COLUMN task_id SET DEFAULT nextval('public.mark_task_id_seq'::regclass);
 >   ALTER TABLE public."Marks" ALTER COLUMN task_id DROP DEFAULT;
       public          postgres    false    235    218            �           2604    16860    Pairs id    DEFAULT     h   ALTER TABLE ONLY public."Pairs" ALTER COLUMN id SET DEFAULT nextval('public."Pairs_id_seq"'::regclass);
 9   ALTER TABLE public."Pairs" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            �           2604    16861    Professors id    DEFAULT     r   ALTER TABLE ONLY public."Professors" ALTER COLUMN id SET DEFAULT nextval('public."Professors_id_seq"'::regclass);
 >   ALTER TABLE public."Professors" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            �           2604    16862    Schedule id    DEFAULT     n   ALTER TABLE ONLY public."Schedule" ALTER COLUMN id SET DEFAULT nextval('public."Schedule_id_seq"'::regclass);
 <   ALTER TABLE public."Schedule" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    16863    Student_book id    DEFAULT     v   ALTER TABLE ONLY public."Student_book" ALTER COLUMN id SET DEFAULT nextval('public."Student_book_id_seq"'::regclass);
 @   ALTER TABLE public."Student_book" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225            �           2604    16864    Students id    DEFAULT     n   ALTER TABLE ONLY public."Students" ALTER COLUMN id SET DEFAULT nextval('public."Students_id_seq"'::regclass);
 <   ALTER TABLE public."Students" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            �           2604    16865    Subjects id    DEFAULT     l   ALTER TABLE ONLY public."Subjects" ALTER COLUMN id SET DEFAULT nextval('public."Lesson_id_seq"'::regclass);
 <   ALTER TABLE public."Subjects" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216            �           2604    16866    Tasks id    DEFAULT     f   ALTER TABLE ONLY public."Tasks" ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);
 9   ALTER TABLE public."Tasks" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    229            �           2604    16867    Tasks subject_id    DEFAULT     v   ALTER TABLE ONLY public."Tasks" ALTER COLUMN subject_id SET DEFAULT nextval('public.tasks_subject_id_seq'::regclass);
 A   ALTER TABLE public."Tasks" ALTER COLUMN subject_id DROP DEFAULT;
       public          postgres    false    237    229            �           2604    17022    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    255    254            [          0    16710 
   Classrooms 
   TABLE DATA           2   COPY public."Classrooms" (id, "Name") FROM stdin;
    public          postgres    false    209   #�       \          0    16713 
   Group_List 
   TABLE DATA           h   COPY public."Group_List" (id, "Student_id", "Group_id", "Strat_date", "End_date", "Active") FROM stdin;
    public          postgres    false    210   a�       ^          0    16718    Groups 
   TABLE DATA           .   COPY public."Groups" (id, "Name") FROM stdin;
    public          postgres    false    212   ~�       `          0    16723    Journal 
   TABLE DATA           O   COPY public."Journal" (id, "Student_id", "Schedule_id", "Visited") FROM stdin;
    public          postgres    false    214   ��       d          0    16733    Marks 
   TABLE DATA           @   COPY public."Marks" (id, student_id, task_id, mark) FROM stdin;
    public          postgres    false    218   �       e          0    16737    Pairs 
   TABLE DATA           ?   COPY public."Pairs" (id, "Start_time", "End_time") FROM stdin;
    public          postgres    false    219   q�       g          0    16742 
   Professors 
   TABLE DATA           T   COPY public."Professors" (id, "First_Name", "Last_Name", "Middle_Name") FROM stdin;
    public          postgres    false    221   ��       i          0    16750    Schedule 
   TABLE DATA           t   COPY public."Schedule" (id, "Group_id", "Lesson_id", "Professor_id", "Pair_id", "Date", "Classroom_id") FROM stdin;
    public          postgres    false    223   ��       k          0    16755    Student_book 
   TABLE DATA           [   COPY public."Student_book" (id, "Student_id", "Lesson_id", "Semester", "Mark") FROM stdin;
    public          postgres    false    225   ��       m          0    16760    Students 
   TABLE DATA           ^   COPY public."Students" (id, "First_Name", "Last_Name", "Group_id", "Middle_Name") FROM stdin;
    public          postgres    false    227   ��       b          0    16728    Subjects 
   TABLE DATA           0   COPY public."Subjects" (id, "Name") FROM stdin;
    public          postgres    false    216   ��       o          0    16768    Tasks 
   TABLE DATA           9   COPY public."Tasks" (id, subject_id, "Text") FROM stdin;
    public          postgres    false    229   5�       v          0    17017    users 
   TABLE DATA           E   COPY public.users (id, username, password, sign_up_date) FROM stdin;
    public          postgres    false    254   ��       �           0    0    Group_List_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Group_List_id_seq"', 1, false);
          public          postgres    false    211            �           0    0    Groups_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."Groups_id_seq"', 3, true);
          public          postgres    false    213            �           0    0    Journal_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Journal_id_seq"', 226, true);
          public          postgres    false    215            �           0    0    Lesson_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."Lesson_id_seq"', 9, true);
          public          postgres    false    217            �           0    0    Pairs_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Pairs_id_seq"', 7, true);
          public          postgres    false    220            �           0    0    Professors_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Professors_id_seq"', 7, true);
          public          postgres    false    222            �           0    0    Schedule_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Schedule_id_seq"', 59, true);
          public          postgres    false    224            �           0    0    Student_book_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Student_book_id_seq"', 1, false);
          public          postgres    false    226            �           0    0    Students_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Students_id_seq"', 7, true);
          public          postgres    false    228            �           0    0    classroom_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.classroom_id_seq', 6, true);
          public          postgres    false    231            �           0    0    mark_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.mark_id_seq', 105, true);
          public          postgres    false    233            �           0    0    mark_student_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.mark_student_id_seq', 1, false);
          public          postgres    false    234            �           0    0    mark_task_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.mark_task_id_seq', 1, false);
          public          postgres    false    235            �           0    0    tasks_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.tasks_id_seq', 14, true);
          public          postgres    false    236            �           0    0    tasks_subject_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tasks_subject_id_seq', 1, false);
          public          postgres    false    237            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 1, true);
          public          postgres    false    255            �           2606    16880 $   Group_List Group_List_Student_id_key 
   CONSTRAINT     k   ALTER TABLE ONLY public."Group_List"
    ADD CONSTRAINT "Group_List_Student_id_key" UNIQUE ("Student_id");
 R   ALTER TABLE ONLY public."Group_List" DROP CONSTRAINT "Group_List_Student_id_key";
       public            postgres    false    210            �           2606    16882    Group_List Group_List_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Group_List"
    ADD CONSTRAINT "Group_List_pk" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Group_List" DROP CONSTRAINT "Group_List_pk";
       public            postgres    false    210            �           2606    16884    Groups Groups_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public."Groups"
    ADD CONSTRAINT "Groups_pk" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Groups" DROP CONSTRAINT "Groups_pk";
       public            postgres    false    212            �           2606    16886    Journal Journal_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public."Journal"
    ADD CONSTRAINT "Journal_pk" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Journal" DROP CONSTRAINT "Journal_pk";
       public            postgres    false    214            �           2606    16888    Subjects Lesson_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public."Subjects"
    ADD CONSTRAINT "Lesson_pk" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Subjects" DROP CONSTRAINT "Lesson_pk";
       public            postgres    false    216            �           2606    16890    Pairs Pairs_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public."Pairs"
    ADD CONSTRAINT "Pairs_pk" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Pairs" DROP CONSTRAINT "Pairs_pk";
       public            postgres    false    219            �           2606    16892    Professors Professors_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Professors"
    ADD CONSTRAINT "Professors_pk" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Professors" DROP CONSTRAINT "Professors_pk";
       public            postgres    false    221            �           2606    16894    Schedule Schedule_pk 
   CONSTRAINT     V   ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_pk" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Schedule" DROP CONSTRAINT "Schedule_pk";
       public            postgres    false    223            �           2606    16896    Student_book Student_book_pk 
   CONSTRAINT     ^   ALTER TABLE ONLY public."Student_book"
    ADD CONSTRAINT "Student_book_pk" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."Student_book" DROP CONSTRAINT "Student_book_pk";
       public            postgres    false    225            �           2606    16898    Students Students_pk 
   CONSTRAINT     V   ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "Students_pk" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Students" DROP CONSTRAINT "Students_pk";
       public            postgres    false    227            �           2606    16900    Classrooms classroom_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Classrooms"
    ADD CONSTRAINT classroom_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY public."Classrooms" DROP CONSTRAINT classroom_pkey;
       public            postgres    false    209            �           2606    16902    Marks mark_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT mark_pkey PRIMARY KEY (id);
 ;   ALTER TABLE ONLY public."Marks" DROP CONSTRAINT mark_pkey;
       public            postgres    false    218            �           2606    16904    Tasks tasks_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Tasks"
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."Tasks" DROP CONSTRAINT tasks_pkey;
       public            postgres    false    229            �           2606    17027    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    254            �           2606    16922    Group_List Group_List_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public."Group_List"
    ADD CONSTRAINT "Group_List_fk0" FOREIGN KEY ("Student_id") REFERENCES public."Students"(id);
 G   ALTER TABLE ONLY public."Group_List" DROP CONSTRAINT "Group_List_fk0";
       public          postgres    false    227    3008    210            �           2606    16927    Group_List Group_List_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public."Group_List"
    ADD CONSTRAINT "Group_List_fk1" FOREIGN KEY ("Group_id") REFERENCES public."Groups"(id);
 G   ALTER TABLE ONLY public."Group_List" DROP CONSTRAINT "Group_List_fk1";
       public          postgres    false    210    212    2992            �           2606    16932    Journal Journal_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public."Journal"
    ADD CONSTRAINT "Journal_fk0" FOREIGN KEY ("Student_id") REFERENCES public."Students"(id);
 A   ALTER TABLE ONLY public."Journal" DROP CONSTRAINT "Journal_fk0";
       public          postgres    false    3008    227    214            �           2606    16937    Journal Journal_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public."Journal"
    ADD CONSTRAINT "Journal_fk1" FOREIGN KEY ("Schedule_id") REFERENCES public."Schedule"(id);
 A   ALTER TABLE ONLY public."Journal" DROP CONSTRAINT "Journal_fk1";
       public          postgres    false    214    3004    223            �           2606    16942    Schedule Schedule_fk0    FK CONSTRAINT     ~   ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_fk0" FOREIGN KEY ("Group_id") REFERENCES public."Groups"(id);
 C   ALTER TABLE ONLY public."Schedule" DROP CONSTRAINT "Schedule_fk0";
       public          postgres    false    223    212    2992            �           2606    16947    Schedule Schedule_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_fk1" FOREIGN KEY ("Lesson_id") REFERENCES public."Subjects"(id);
 C   ALTER TABLE ONLY public."Schedule" DROP CONSTRAINT "Schedule_fk1";
       public          postgres    false    223    2996    216            �           2606    16952    Schedule Schedule_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_fk2" FOREIGN KEY ("Professor_id") REFERENCES public."Professors"(id);
 C   ALTER TABLE ONLY public."Schedule" DROP CONSTRAINT "Schedule_fk2";
       public          postgres    false    223    3002    221            �           2606    16957    Schedule Schedule_fk3    FK CONSTRAINT     |   ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_fk3" FOREIGN KEY ("Pair_id") REFERENCES public."Pairs"(id);
 C   ALTER TABLE ONLY public."Schedule" DROP CONSTRAINT "Schedule_fk3";
       public          postgres    false    219    3000    223            �           2606    16962    Schedule Schedule_fk4    FK CONSTRAINT     �   ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_fk4" FOREIGN KEY ("Classroom_id") REFERENCES public."Classrooms"(id);
 C   ALTER TABLE ONLY public."Schedule" DROP CONSTRAINT "Schedule_fk4";
       public          postgres    false    209    2986    223            �           2606    16967    Student_book Student_book_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public."Student_book"
    ADD CONSTRAINT "Student_book_fk0" FOREIGN KEY ("Student_id") REFERENCES public."Students"(id);
 K   ALTER TABLE ONLY public."Student_book" DROP CONSTRAINT "Student_book_fk0";
       public          postgres    false    227    225    3008            �           2606    16972    Student_book Student_book_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public."Student_book"
    ADD CONSTRAINT "Student_book_fk1" FOREIGN KEY ("Lesson_id") REFERENCES public."Subjects"(id);
 K   ALTER TABLE ONLY public."Student_book" DROP CONSTRAINT "Student_book_fk1";
       public          postgres    false    225    2996    216            �           2606    16977    Students Students_fk0    FK CONSTRAINT     ~   ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "Students_fk0" FOREIGN KEY ("Group_id") REFERENCES public."Groups"(id);
 C   ALTER TABLE ONLY public."Students" DROP CONSTRAINT "Students_fk0";
       public          postgres    false    2992    227    212            �           2606    16982    Marks mark_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT mark_student_id_fkey FOREIGN KEY (student_id) REFERENCES public."Students"(id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public."Marks" DROP CONSTRAINT mark_student_id_fkey;
       public          postgres    false    3008    218    227            �           2606    16987    Marks mark_task_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT mark_task_id_fkey FOREIGN KEY (task_id) REFERENCES public."Tasks"(id);
 C   ALTER TABLE ONLY public."Marks" DROP CONSTRAINT mark_task_id_fkey;
       public          postgres    false    229    3010    218            �           2606    16992    Tasks tasks_subject_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Tasks"
    ADD CONSTRAINT tasks_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public."Subjects"(id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public."Tasks" DROP CONSTRAINT tasks_subject_id_fkey;
       public          postgres    false    229    216    2996            [   .   x�3�t713�2Q�\� ʂ�H�p�)s.3 en����� ��      \      x������ � �      ^   %   x�3估�²k��@���rs^��+�b���� ��      `   L  x�%�K�%1׮ô���>��_C$z���$cq����g9�����:��>az6؂n�+\2�؆��P��o�p���E��l�ق;���W��3�tz�S]?T��r�,��g��}0��ڹ/f�:�f�{1K9\�:�=`�X�Bo����2\��Z��4/
Å	�p��p���&U��F����c1x�Y�]�`؂W�T5\�b�\^K��_�r�,��Y�[�����}����=�
Wa�8K�����FmZ�}�U@������-��e��y���+�� k��.�Or���f����l��Fiݘn2�ߟ��� ��v      d   R  x�%��q!���`���T���V7o�n�,��f�w�
�8|%(�
.�OV!�-��ClhC���{�`�W �o�����<`#��p�L6�O�<�`���' ��𨞻>�mw}a9xI�;W���� W�IQ&qr����2y^��L���PA= ��p?�؎W>-��3��u7-��W��g{�E.j�yCP ��ꋖV=�����-?��=��"f0��0�}L��b»���Eń�5:m��5C	)�����GW�y;�0eb������̥�O}��h ����Z~4��Ϙ��\���up�����{��[r.      e   L   x�5��	�0ľ�a�q<K�����
�a�+�T�a�Z;�y\ �]�7�l�m�.��v��������D�H
V      g   �   x���M
�P��y�)�Su�MUDA�X����w�ɍ�ĭq���L��:��Ѡ^��@I顩��ZS�)ר�h���F��sO����{2QSͿYƂ-{+c(��}�.�d�I�=�":���:Lg#4s.~8�f�D+j9Sf�/����?�4����`��yBx�ݶ      i   5  x�m�An� �u|�_�������Ƹm`P�E�� a�O����)�ON�?|�	�Rw�9X#��f(���J�B.<,��9E��#�t������n������BW3���J�Y�ͻ��|�/�����c��gb�u����_H|ٯ�e������~o����G�辯�"����*��ms|������#�7w��ˑӰ�m^��=t������m���8���9�����uz���v�쏏��9�7�O��׎�q؟���y%�}qg�/��ŬI�~�y�E������A?W~�~.�O�B�_D�U��      k      x������ � �      m   �   x�uPK
�@]g#Ԫ��0UE���=���0vl��r#_ZĂ���%���(P	V,�xJ$�֓�9�^S��P!��Љ����=��z�7�&-R,X�	�H��#��u�h����dT��gA*�L\(,f`SP'k��M̻/ر)9�L���u)q��Oԁ`��˾�J���9ۢ��-��{���7      b   a  x�mQKN�0]ǧ� �?,Y�� lP)P	(jž��@*��#N@�6�I��
oněI�@�(�Ǟy?�G��痭�?kw�A��y�j����M��캍�H�s>2�O*}�Gƍ��mFxG�X�U��K�!�E�%#��3�%�ǔ�Pn+�f2D���yP`�� ����%2V�Z+z��q�
h��0��kզ��A�J����)gPu���DxἚ��U3��i�g�<.�?=ʩi%�s�^	�9'J�d�0�ˠr�Ȗ��Ex[fG���}y�k�!59uJ<[pK�g?��J*��B�3�֟�\lW7����q必��K��?�*B��қ��D=���=Z�1w�����N      o   z  x��RKN�P\?����xI
�St��M$$X��]� >jԲ@b��iڊ�O��1N�J�@(jT{�{g�9�]_Yװ�0l؈B���٩\3)چ�fС�	�r��\�s�2����)^�%�2@6�9/8TpF������ӝr���T��_\��,r�4(�j�R]�+ 	[ΰA�$��-��eJ �S�Ңg�3@SЏ�@� 7��P��G�G��o�	9ۊ�$�C~�Aə��vooί.��)�3��b_� #㏦�҄d��㹜�P]�l@X��XG.��$ ���ĺ�Wgtm��2�,��K[f��F��\�g�Jw����Ų;�7�5�6�.���R���<(�$��('g:}Zk�~P��TU)����(���      v   =   x�3��,p��IuI-.�0KL17026N��46052R�L,,LL��RM�S8c��b���� �i%     