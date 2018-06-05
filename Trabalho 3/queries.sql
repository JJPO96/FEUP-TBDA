-- a)

select distinct gtd8.facilities.id, name, description, activity
from gtd8.facilities
join gtd8.roomtypes
on gtd8.facilities.roomtype = gtd8.roomtypes.roomtype
join gtd8.uses
on gtd8.uses.id = gtd8.facilities.id
join gtd8.activities
on gtd8.activities.ref = gtd8.uses.ref
where gtd8.roomtypes.description like '%touros%'
    and gtd8.activities.activity = 'teatro';

-- b)

select region, count(*) as nr_facilities
from gtd8.regions
join gtd8.municipalities
on gtd8.regions.cod = gtd8.municipalities.region
join gtd8.facilities
on gtd8.facilities.municipality = gtd8.municipalities.cod
join gtd8.roomtypes
on gtd8.facilities.roomtype = gtd8.roomtypes.roomtype
where gtd8.roomtypes.description like '%touros%'
group by region;

-- c)

create or replace view count_municipalities_cinema as
select count(*) as val
from (
select distinct cod
from gtd8.municipalities
join gtd8.facilities
on gtd8.facilities.municipality = gtd8.municipalities.cod
join gtd8.uses
on gtd8.uses.id = gtd8.facilities.id
join gtd8.activities
on gtd8.activities.ref = gtd8.uses.ref
where activity = 'cinema'
order by cod);

create or replace view count_total as
select count(*) as total
from gtd8.municipalities;

select total-val as nr
from count_municipalities_cinema, count_total;

-- d)

create or replace view count_facilities_municipality as 
select cod, activity, count(*) as nr_facilities
from gtd8.municipalities
join gtd8.facilities
on gtd8.facilities.municipality = gtd8.municipalities.cod
join gtd8.uses
on gtd8.uses.id = gtd8.facilities.id
join gtd8.activities
on gtd8.activities.ref = gtd8.uses.ref
group by cod, activity;

create or replace view max_facilities_activity as
select activity, max(nr_facilities) as nr_facilities
from count_facilities_municipality
group by activity;

select cod, max_facilities_activity.activity, max_facilities_activity.nr_facilities
from count_facilities_municipality, max_facilities_activity
where max_facilities_activity.nr_facilities = count_facilities_municipality.nr_facilities
and max_facilities_activity.activity = count_facilities_municipality.activity;

-- e)

create or replace view nr_municipalities_per_district as
select district, count(*) as nr_municipalities
from gtd8.districts
join gtd8.municipalities
on gtd8.municipalities.district = gtd8.districts.cod
group by district
order by district;

create or replace view aux as
select distinct district, gtd8.municipalities.cod
from gtd8.districts
join gtd8.municipalities
on gtd8.municipalities.district = gtd8.districts.cod
join gtd8.facilities
on gtd8.facilities.municipality = gtd8.municipalities.cod
order by district;

create or replace view nr_mun_with_fac_per_district as
select district, count(*) as nr_municipalities
from aux
group by district;

select nr_municipalities_per_district.district, designation
from nr_municipalities_per_district, nr_mun_with_fac_per_district, gtd8.districts
where nr_mun_with_fac_per_district.nr_municipalities = nr_municipalities_per_district.nr_municipalities
    and nr_mun_with_fac_per_district.district = nr_municipalities_per_district.district
    and gtd8.districts.cod = nr_municipalities_per_district.district;