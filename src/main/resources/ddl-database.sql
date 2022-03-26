do
$setup_database$
begin
	create sequence if not exists hibernate_sequence;

	create table if not exists "user" (
	    use_cod bigint not null generated by default as identity,
	    use_name varchar not null,
	    use_email varchar not null,
	    use_phone varchar not null,
		use_password varchar not null,
	    constraint user_use_cod_pkey primary key (use_cod),
	    constraint user_use_email_ukey unique (use_email),
	    constraint user_use_phone_ukey unique (use_phone)
	);

	if not exists (select from "user" limit 1) then
		insert into "user" 
			(use_name, use_email, use_phone, use_password)
		values 
			('Wesley', 'wesley@bureautech.com', '12000000000', '$2a$10$jIBLpcQ.xW3JpLCgKsCOIeFABuV.wExt8Pmvx/qKyWuEE1inUqKja'),
			('Ana', 'ana@bureautech.com', '12000000001', '$2a$10$4Ax9pIDt.FmXtZ5nXYHjaevg6UJW8B0Fbj6mZJjBkqsbQ3WsztB3W'),
			('Beatriz', 'beatriz@bureautech.com', '12000000002', '$2a$10$zBKmTYdNOavPuhGrBsiaROghkCMf4XINQVucvQ9InYbjnBq5uLkiG'),
			('Denis', 'denis@bureautech.com', '12000000003', '$2a$10$dWGye8PzeljyWMyDbxF2ZeXoJHmDthrVpeg3VzyN82Bm/0yLUSK.y'),
			('Daniel', 'daniel@bureautech.com', '12000000004', '$2a$10$JRQjYa95eAIkDpy3HQ890.QAbsqSA8b5iix67kO6on54WonpgRvgm'),
			('Caique', 'caique@bureautech.com', '12000000005', '$2a$10$srxSySPHfbsag3QGK.r7AedethRN3cmrn6U1mQjiQ4iK.4vJrUvjy'),
			('Charles', 'charles@bureautech.com', '12000000006', '$2a$10$jLQj2i57O05dfWRRw.hCmOUQ.NL35i4HuZ4kOJplv4gaJlC2DHD4u'),
			('Admin', 'admin@bureautech.com', '12000000007', '$2a$10$1vPo8AKcYUY15Ijtz1pNXuxVofvw/go6UnICXICwS0x0CAuXa5pNe');
	end if;


	if exists (select from pg_catalog.pg_roles where rolname = 'app_btalert') then
		reassign owned by app_btalert to postgres;
		drop owned by app_btalert;
		drop user app_btalert;
	end if;

	create user app_btalert with encrypted password 'BR:.>LuT`Lbs%6t@99w!4+Ch' 
		nosuperuser inherit nocreatedb nocreaterole noreplication valid until 'infinity';
 	grant connect on database postgres to app_btalert;
	grant usage on schema public to app_btalert;
	grant select, insert, update, delete on all tables in schema public to app_btalert;
	grant usage, select on all sequences in schema public to app_btalert;
end
$setup_database$;
