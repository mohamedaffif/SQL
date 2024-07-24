select * from sales;
select * from people;

select s.saleDate, s.amount, P.Salesperson, s.SPID, p.spid
from sales as s
join people as p on p.SPID = s.SPID;

select s.saleDate, s.amount, pr.product
from sales as s
left join products pr on pr.pid = s.pid;


select s.saleDate, s.amount, P.Salesperson, pr.product, p.team
from sales as s
join people as p on p.SPID = s.SPID
left join products pr on pr.pid = s.pid;



select s.saleDate, s.amount, P.Salesperson, pr.product, p.team
from sales as s
join people as p on p.SPID = s.SPID
left join products pr on pr.pid = s.pid
where s.amount < 500
and p.team = "";


select s.saleDate, s.amount, P.Salesperson, pr.product, p.team
from sales as s
join people as p on p.SPID = s.SPID
left join products pr on pr.pid = s.pid
join geo g on g.geoid = s.geoid
where s.amount < 500
and p.team = ""
and g.Geo in ('New Zealand', 'India')
order by saleDate;


