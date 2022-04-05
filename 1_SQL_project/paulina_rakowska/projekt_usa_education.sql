-- g�osowanie w zale�no�ci od wykszta�cenia

create table education as
select
	pr.county,	
	pr.state ,
	pr.candidate,
	pr.party,
	pr.votes,
	pr.fraction_votes,
	cf."EDU635213" as high_school_higher,
	cf."EDU685213" as bachelor_or_higher
from county_facts cf 
join primary_results pr on cf.fips = pr.fips 

SELECT 
	max(e.high_school_higher) as max_hs,
	min(e.high_school_higher),
	(max(e.high_school_higher) - min(e.high_school_higher)) / 4 as interval_hs,
	max(e.bachelor_or_higher) as max_b,
	min(e.bachelor_or_higher),
	(max(e.bachelor_or_higher) - min(e.bachelor_or_higher)) / 4 as interval_b
from education e 


--g�osowanie w zale�no�ci od liczby os�b z wykszta�ceniem high_school (odpowiednik polskiego liceum) lub wy�szym

SELECT 
	distinct(e.candidate),
	e.party,
	sum(e.votes) over (partition by e.party) as sum_votes_party,
	sum(e.votes) over (partition by e.candidate) as sum_votes_candidate
from education e 
where e.high_school_higher between 45.0 and 58.5 
order by sum_votes_candidate DESC

SELECT 
	distinct(e.candidate),
	e.party,
	sum(e.votes) over (partition by e.party) as sum_votes_party,
	sum(e.votes) over (partition by e.candidate) as sum_votes_candidate
from education e 
where e.high_school_higher between 58.5 and 72.0
order by sum_votes_candidate DESC

SELECT 
	distinct(e.candidate),
	e.party,
	sum(e.votes) over (partition by e.party) as sum_votes_party,
	sum(e.votes) over (partition by e.candidate) as sum_votes_candidate
from education e 
where e.high_school_higher between 72.0 and 85.5
order by sum_votes_candidate DESC

SELECT 
	distinct(e.candidate),
	e.party,
	sum(e.votes) over (partition by e.party) as sum_votes_party,
	sum(e.votes) over (partition by e.candidate) as sum_votes_candidate
from education e 
where e.high_school_higher between 85.5 and 99.0
order by sum_votes_candidate desc

select -- w kt�rych stanach jest najmniej os�b z wykszta�cenie high school lub wy�szym 
	cf.area_name,
	cf."EDU635213" 
from county_facts cf 
where cf.fips like '%000' and cf."EDU635213" < 85.0
order by cf."EDU635213" asc

select -- w kt�rych stanach jest najwi�cej hrabstwa, w kt�rych jest najmniej os�b z wykszta�ceniem �rednim
	e.state ,
	count(*) as num_county
from education e 
where e.high_school_higher between 45.0 and 58.5
group by e.state
order by num_county desc

select -- w kt�rych stanach jest najwi�cej os�b z wykszta�cenie high school lub wy�szym 
	cf.area_name,
	cf."EDU635213" 
from county_facts cf 
where cf.fips like '%000' and cf."EDU635213" > 90.0
order by cf."EDU635213" desc

select -- w kt�rych stanach jest najwi�cej hrabstwa, w kt�rych jest najwi�cej os�b z wykszta�ceniem �rednim
	e.state ,
	count(*) as num_county
from education e 
where e.high_school_higher between 85.5 and 99.0
group by e.state
order by num_county desc




--g�osowanie w zale�no�ci od liczby os�b z wykszta�ceniem bachelor (studia I stopnia, odpowiednik polskiego licencjatu) lub wy�szym

SELECT 
	distinct(e.candidate),
	e.party,
	sum(e.votes) over (partition by e.party) as sum_votes_party,
	sum(e.votes) over (partition by e.candidate) as sum_votes_candidate
from education e 
where e.bachelor_or_higher between 3.2 and 21.0 
order by sum_votes_candidate DESC

SELECT 
	distinct(e.candidate),
	e.party,
	sum(e.votes) over (partition by e.party) as sum_votes_party,
	sum(e.votes) over (partition by e.candidate) as sum_votes_candidate
from education e 
where e.bachelor_or_higher between 21.0 and 38.8 
order by sum_votes_candidate DESC

SELECT 
	distinct(e.candidate),
	e.party,
	sum(e.votes) over (partition by e.party) as sum_votes_party,
	sum(e.votes) over (partition by e.candidate) as sum_votes_candidate
from education e 
where e.bachelor_or_higher between 38.8 and 56.6 
order by sum_votes_candidate DESC

SELECT 
	distinct(e.candidate),
	e.party,
	sum(e.votes) over (partition by e.party) as sum_votes_party,
	sum(e.votes) over (partition by e.candidate) as sum_votes_candidate
from education e 
where e.bachelor_or_higher between 56.6 and 74.5
order by sum_votes_candidate desc

select -- w kt�rych stanach jest najmniej os�b z wykszta�cenie bachelor
	cf.area_name ,	
	cf."EDU685213" 
from county_facts cf 
where cf.fips like '%000' and cf."EDU685213" < 25.0
order by cf."EDU685213" asc

select -- w kt�rych stanach jest najwi�cej hrabstwa, w kt�rych jest najmniej os�b z wykszta�ceniem wy�szym
	e.state ,
	count(*) as num_county
from education e 
where e.bachelor_or_higher between 3.2 and 21.0
group by e.state
order by num_county desc

select -- w kt�rych stanach jest najwi�cej os�b z wykszta�cenie bachelor lub wy�szym 
	cf.area_name,
	cf."EDU685213" 
from county_facts cf 
where cf.fips like '%000' and cf."EDU685213" > 35.0
order by cf."EDU685213" desc

select -- w kt�rych stanach jest najwi�cej hrabstwa, w kt�rych jest najwi�cej os�b z wykszta�ceniem wy�szym
	e.state ,
	count(*) as num_county
from education e 
where e.high_school_higher between 56.6 and 74.5
group by e.state
order by num_county desc
