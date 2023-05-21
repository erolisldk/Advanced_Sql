--*******************GUN--2*************************

--film tablosundan id' si 1 olan aktorun tum bilgilerini aliniz.

do $$
declare
	selected_actor actor%rowtype; -- rowtype secili row'un tum bilgilerini depolayabilmek icin kullanilir.
	
begin
	select * 
	from actor
	into selected_actor
	where id=1;
	
	raise notice '% %', selected_actor.first_name,selected_actor.last_name;
end$$



--******************  RECORD TYPE ****************************** (record bazi programlarda row anlaminda kullaniliyor)

-- Film tablosundan id'si 2 olan datanin yalnizca id, title ve type bilgisini al.

do $$

declare 
	rec record ; -- Record Type : Row Type gibi tüm degerleri bastan sona almaz, tablodaki belirli datalarin bilgilerini verir.
	
begin

	select id, title, type 
	from film
	into rec
	where id=2;
	
	raise notice 'Id: %, Film Ismi:  %, Tur: %', rec.id, rec.title, rec.type;
	
end $$;


-- ************************* IC ICE BLOK YAPILARI *************************

do $$
<<outerblock>>
declare -- Tepedeki blok, outer block olarak geciyor.
	counter integer := 0;
	
begin

	counter := counter+1;
	raise notice 'Outer block Counter Degeri: %', counter;
	
	declare -- Inner block baslangici
		counter integer :=0;
	
	begin
	counter := counter+10;
	raise notice ' Inner block counter degeri : %', counter;
	
	raise notice 'Dis bloktaki Counter degeri: %', outerblock.counter;
	
	end; -- Inner Block sonu

end $$ ;-- Outer block sonu



--*******************CONSTANT DEGERLER *********************
--KDV degerini sabit deger yap.

do $$
declare 
	--selling_price := net_price *0.1;
	vat constant numeric :=0.1; -- constant deger, sabir deger. Begin icerisinde tekrar degistirilemez.
	net_price numeric := 20.5;
begin
	raise notice 'Satis Fiyati: %', net_price*vat;


end $$;

-- CONSTANT'larin degismediginin kanit ornegi
do $$
declare
 	olusturulma constant integer := 17;
begin
	raise notice 'Olusturulma zamani: %', olusturulma;
	
	--olusturulma := 18;
	--raise notice 'Yeni Olusturulma zamani: %', olusturulma;
end $$;


-- ******************************** CONTROL YAPILARI ******************************
-- *********************** IF STATEMENT ***************************


--sytax

/*
	IF condition THEN 
		islemler
	END IF;
*/

--Task 1: 1 Id'li filmi bulmaya calis, bulunursa bulundu yazisini print et.

--if found
do $$
declare
	selected_film film%rowtype; -- Film objesi kullanılacak
	input_film_id film.id%type := 1; -- Kullanıcının girdiği id numarası
begin
	
	SELECT * FROM film
	INTO selected_film
	WHERE id=input_film_id;
 	
	-- Bulduğumuz filmin title'ını getir
	--raise notice '%', selected_film.title;
	
	if found then
		raise notice 'Bulundu: %', selected_film.title;
	end if;
end $$;



--if not  found
do $$
declare
	selected_film film%rowtype; -- Film objesi kullanılacak
	input_film_id film.id%type := 10; -- Kullanıcının girdiği id numarası
begin
	
	SELECT * FROM film
	INTO selected_film
	WHERE id=input_film_id;
 	
	-- Bulduğumuz filmin title'ını getir
	--raise notice '%', selected_film.title;
	
	if not found then
		raise notice 'Bulunamadı! ----> %', input_film_id;
	end if;
end $$;


-- ******************** IF - ELSE *******************************

/*
	If condition THEN
		islemler;
	ELSE
		alternatif islemler;
		END IF;
*/


-- Task -1 1 Id'li film buunabulurse, title bilgisini yazdir, yoksa BULUNAMADI yazdir.

do $$
declare
	selected_film film%rowtype; -- Film objesi kullanılacak
	input_film_id film.id%type := 10; -- Kullanıcının girdiği id numarası
begin
	
	SELECT * FROM film
	INTO selected_film
	WHERE id=input_film_id;
 	
	-- Bulduğumuz filmin title'ını getir
	--raise notice '%', selected_film.title;
	
	if found then
		raise notice 'Bulundu: %', selected_film.title;
	else
		raise notice 'Bulunamadı: %', input_film_id;
	end if;
end $$;




-- ******** IF - ELSE IF - ELSE
-- syntax:
/*
	IF condition THEN
		işlemler;
	ELSEIF condition_2 THEN
		işlemler;
	ELSEIF condition_3 THEN
		işlemler;
	ELSE
		işlemler;
	END IF;
*/
/*
	Task:
	
	1 ID'li film bulunursa:
	
		Süresi 50 dakikanın altında ise "Kısa",
		50 ile 120 arasında ise "Ortalama",
		120 dakikadan fazla ise "Uzun"
		print edelim.
*/
do $$
declare
	oFilm film%rowtype;
	lenDescription varchar(50);
	film_id film.id%type;
begin
	SELECT * FROM film
	INTO oFilm
	WHERE id=film_id;
	
	if not found then
		raise notice 'Film bulunamadı!';
	else
		if oFilm.length>0 and oFilm.length<50 then
			lenDescription := 'Kısa';
		elseif oFilm.length>50 and oFilm.length<120 then
			lenDescription := 'Ortalama';
		elseif oFilm.length>120 then
			lenDescription := 'Uzun';
		else
			lenDescription := 'Tanımlanamıyor.';
		end if;
		
		raise notice '% filminin uzunlugu: %', oFilm.title, lenDescription;
		
	end if;
	
end $$;


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	