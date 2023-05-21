
-- dolar isareti --> tirnak isareti yerine kullaniyoruz
/*
text
*/

-- *************** DEGISKEN TANIMLAMA *********************

do $$  --> isim vermedigimiz blocklarin basina yaziliyor. Isimleri de anonymous olarak anilir. 

declare 

	counter integer := 1; -- counter adinde bir degisken olusturuldu. Default degeri 1 olarak atandi
	first_name varchar(50) :='Bahadir';
	last_name varchar(50) := 'Gunuvar';
	payment numeric(4,2) := 20.50; --20.50 --parantez icindeki 4 sayinin 4 karakter olmasi gerektigini 2 ise virgulden sonraki karakter sayisini verir
			--numeric(precision,scale)
	
begin
	--raise notice 'Isim % Soyisim %', first_name, last_name; --raise ortaya cikar demek (Javadaki print gibi) ve outputun aciklamasini verir
	--Bahadir Gunuvar 20,5 USD odeme aldi.
	raise notice 'Isim: % Soyisim: % Odeme: %', first_name, last_name, payment ; 

end $$


/*
	Task 1 : değişkenler oluşturarak ekrana " Ahmet ve Mehmet beyler 120 tl ye bilet aldılar. "
	cümlesini ekrana yazdırınız.
*/

do $$

declare

name varchar (50) := 'Ahmet';
name2 varchar(50) := 'Mehmet';
payment numeric (3) := 120;

begin
raise notice '% ve % Beyler % TL ye bilet aldilar',
name, name2, payment ;



--************************ BEKLETME KOMUTU

do $$

declare
created_at time := now(); -- time--> data type, now() olusturldugu zaman

begin
	raise notice '%', created_at;
	perform pg_sleep(5); -- 5 saniye bekle
	raise notice '%', created_at;
end $$ ;


-- ******** TABLODAN DATA TIPINI KOPYALAMA ********

do $$
declare
	f_title film.title%type;  -- text
begin
	-- 1 ID'li filmin ismini geirelim
	SELECT title
	FROM film
	INTO f_title -- Uncharted
	WHERE id=1;
	
	raise notice '%', f_title;
end $$;

do $$
declare
	f_title film.title%type; -- text
	
	sure film.length%type;
	
begin
	-- 1 ID'li filmin ismini getirelim
	SELECT title
	FROM film
	INTO f_title -- Uncharted
	WHERE id=1;
	
	raise notice 'Film Başlığı: %', f_title;
	
	
	SELECT length
	FROM film
	INTO sure
	WHERE id=1;
	
	raise notice 'Film süresi: %', sure;
	
	
end $$;

