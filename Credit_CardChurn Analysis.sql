use credit_card;

#Total dataset
select * from bankchurn;

#1. Count of Existing and Attrited Customer
select count(Attrition_Flag) as existing_customer from bankchurn where Attrition_Flag = 'Existing Customer';
select count(Attrition_Flag) as attrition_customer from bankchurn where Attrition_Flag = 'Attrited Customer';

#2. Average age of existing customer and Attrited customer
select avg(Customer_Age) from bankchurn where Attrition_Flag = 'Existing Customer';
select avg(Customer_Age) from bankchurn where Attrition_Flag = 'Attrited Customer';

#3. Attrited customer based on age range
select  case 
when Customer_Age between 30 And 40 then '30-40'
when Customer_Age between 40 AND 50 then '40-50'
when Customer_Age between 50 AND 60 then '50-60'
when Customer_Age between 60 And 70 then '60-70'
when Customer_Age<70 then '70'
end as age_range, count(*) 
from bankchurn where Attrition_Flag = 'Attrited customer' group by age_range ;

#4. Number of Male and Female customers in attritied and exsiting customer
select sum(if(Gender = 'M',1, 0)) as 'MaleAtttritedCustomer', sum(if(Gender = 'F',1, 0)) as FemaleAttritedCustomer
from bankchurn where Attrition_Flag = 'Attrited Customer';

select sum(if(Gender = 'M',1, 0)) as 'MaleAtttritedCustomer', sum(if(Gender = 'F',1, 0)) as FemaleAttritedCustomer
from bankchurn where Attrition_Flag = 'Existing Customer';

#5. Education level wise attrited and existing customer
select Education_Level, count(*) as Attrited_customer from bankchurn where Attrition_Flag = 'Attrited Customer' group by Education_Level;
select Education_Level, count(*) as Existing_customer from bankchurn where Attrition_Flag = 'Existing Customer' group by Education_Level;

#6. Marital Status attrited and existing customer
select Marital_Status, count(*) as Existing_customer from bankchurn where Attrition_Flag = 'Existing Customer' group by Marital_Status;
select Marital_Status, count(*) as Attrited_customer from bankchurn where Attrition_Flag = 'Attrited Customer' group by Marital_Status;

#7. Tenure of relationship with bank based on age range
select  case 
when Months_on_book<20 then '0-20' when Months_on_book between 20 And 30 then '20-30'
when Months_on_book between 30 And 40 then '30-40' when Months_on_book between 40 AND 50 then '40-50'
when Months_on_book between 50 AND 60 then '50-60' when Months_on_book between 60 And 70 then '60-70'
when Months_on_book<70 then '70' end as age_range, count(*)
from bankchurn where Attrition_Flag = 'Attrited Customer' group by age_range order by age_range;

#8. Card category has higher attrition rate
select Card_Category, count(*) as AttritedCustomer from bankchurn where Attrition_Flag = 'Attrited Customer' group by Card_Category
order by AttritedCustomer;

#9. Total count of customer in the inactive months
select Months_Inactive_12_mon, count(*) as InactiveCustomer_inmonths from bankchurn 
where Attrition_Flag = 'Attrited Customer' group by Months_Inactive_12_mon order by Months_Inactive_12_mon;

select Months_Inactive_12_mon, count(*) as InactiveCustomer_inmonths from bankchurn 
where Attrition_Flag = 'Exsiting Customer' group by Months_Inactive_12_mon order by Months_Inactive_12_mon;

#10. Avergae Limit of each card category
select Card_Category, avg(Credit_Limit) avg_limit_ofcards from bankchurn where Card_Category IN ('Blue', 'Silver', 'Gold', 'Platinum') group by Card_Category;

#11. Avg_Utilization_Ratio percent of attrited and existing customer
select avg(Avg_Utilization_Ratio*100) as attrited_customer from bankchurn where Attrition_Flag = 'Attrited Customer';
select avg(Avg_Utilization_Ratio*100) as existing_customer from bankchurn where Attrition_Flag = 'Existing Customer';
