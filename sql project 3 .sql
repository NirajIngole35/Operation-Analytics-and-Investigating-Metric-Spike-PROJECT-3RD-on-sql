create database project03;

use project03;

create table job_data(job_id int,actors_id int,event varchar(255),
language varchar(255),time_spent int,org varchar(255),ds date);

 #Data Insert into Table Query:
insert into job_data (job_id,
actors_id, event, language, time_spent, org, ds)
values
(21,1001,'skip','English',15,'A','2020-11-30'),
(22,1006,'transfer', 'Arabic',25,'B','2020-11-30'),
(23,1003,'decision','Persian',20,'C','2020-11-29'),
(24,1005,'transfer','Persian',22,'D','2020-11-28'),
(25,1002,'decision','Hindi', 11,'B','2020-11-28'),
(26,1007, 'decision', 'French', 104,'D', '2020-11-27'),
(27, 1004, 'skip', 'Persian', 56, 'A', '2020-11-26'),
(28,1008, 'transfer', 'Italian', 45,'C','2020-11-25'),
(28, 1008, 'transfer', 'Italian', 45,'C','2020-11-25');

select count(job_id)from project03.job_data;


/*
1.	Number of jobs reviewed:  Amount of jobs reviewed over time.           
 Your Task: Calculate the number of jobs reviewed per hour per day for November 2020?
*/
select
count(distinct job_id)/(30*24) as reviewed_per_hour_per
from project03.job_data  where ds  between 
2020-11-01 and 2020-11-30;

/*
2. Throughput: It is the no. of events happening per second.
Your Task: Let’s say the above metric is called throughput. 
	Calculate 7 day rolling average of throughput? For throughput, 
	do you prefer daily metric or 7-day rolling and why?
*/
select ds,job_review,avg(job_review) over
(order by ds rows between 5 preceding and current row)as throughput
from (select ds,count(distinct job_id) as job_review
from project03.job_data 
where ds between "2020-11-01" and"2020-11-30"
group by ds order by ds)a;


/*
3.Percentage share of each language: Share of each language for different contents.
		Your Task: Calculate the percentage share of each language in the last 30 days?

*/

select language,job_no ,100.0*job_no/all_job  as "%_job"from (select 
language,count(distinct job_id) as job_no from project03.job_data group by language)a
cross join
(select count(distinct job_id)as all_job
from project03.job_data)b
select*from project03.job_data;

/*
4. Duplicate rows:Rows that have the same value present in them.
		 Your task:Let’s say you see some duplicate rows in the data. How will you display duplicates from the table?
*/


select * from 
(select *,row_number()over(partition by job_id)as rownum
from project03.job_data)a
where rownum>1;

SELECT * FROM project03.`user_table-1`;
/*
Case Study 2 (Investigating metric spike):
1) User Engagement: To measure the activeness of a user. 
Measuring if the user finds quality in a product/service. 
             Your task: Calculate the weekly user engagement?
*/


select
extract (week from ccurred_at) as weeknum,count(distinct user_id)
from