use swiggy

if exists (
	 select * from DBA_ROHIT.sys.tables
		where name = 'orderdata'
	 )

begin 
	if exists(
		    select * from swiggyorderdata where  year(date) <> year(getdate())
			)
		begin
		      insert into DBA_ROHIT.dbo.orderdata select * from swiggyorderdata where  year(date) <> year(getdate())

		      DELETE FROM swiggyorderdata WHERE year(date) <> year(getdate());
       END
	
	ELSE 
		begin
			insert into DBA_ROHIT.dbo.orderdata select * from swiggyorderdata where  year(date) <> year(getdate())
		    DELETE FROM swiggyorderdata WHERE year(date) <> year(getdate());


	   END
END

ELSE

begin 
    
		
	if exists
		(   
		    select * from swiggyorderdata where  year(date) <> year(getdate())
						

			)
		begin
		       select * into DBA_ROHIT.dbo.orderdata from  swiggyorderdata where  year(date) <> year(getdate())

			   DELETE FROM swiggyorderdata WHERE year(date) <> year(getdate());

		end
	
	else 
		begin
		       select * into DBA_ROHIT.dbo.orderdata from  swiggyorderdata where  year(date) <> year(getdate())
			   DELETE FROM swiggyorderdata WHERE year(date) <> year(getdate());

		end
END


use swiggy
select * from swiggyorderdata
use DBA_ROHIT
select * from orderdata
